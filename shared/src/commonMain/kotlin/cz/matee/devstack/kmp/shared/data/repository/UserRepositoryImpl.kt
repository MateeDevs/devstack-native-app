package cz.matee.devstack.kmp.shared.data.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.base.util.extension.map
import cz.matee.devstack.kmp.shared.data.source.UserLocalSource
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.data.source.UserRemoteSource
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.model.UserPagingResult
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import cz.matee.devstack.kmp.shared.domain.repository.UserUpdateParameters
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity
import cz.matee.devstack.kmp.shared.infrastructure.local.isLoggedIn
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto
import cz.matee.devstack.kmp.shared.util.extension.asDomain
import cz.matee.devstack.kmp.shared.util.extension.asEntity
import cz.matee.devstack.kmp.shared.util.extension.asUserCache
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map

internal class UserRepositoryImpl(
    private val authDao: AuthDao,
    private val remoteSource: UserRemoteSource,
    private val localSource: UserLocalSource
) : UserRepository {

    override val isUserLoggedIn: Boolean
        get() = authDao.isLoggedIn

    override suspend fun getUser(): Flow<Result<User>> {
        val userId = authDao.retrieveUserId()
            ?: return flow { emit(Result.Error(CommonError.NoUserLoggedIn)) }
        return getUser(userId)
    }

    override fun getUsers(): Flow<List<User>> {
        return localSource.getUsers().map { users -> users.map(UserEntity::asDomain) }
    }

    override suspend fun refreshUsers(pagingRequest: UserPagingRequest): Result<Unit> {
        return when (val result = remoteSource.getUsers(pagingRequest)) {
            is Result.Success -> {
                val users = result.data.data.map { userDto ->
                    UserEntity(
                        id = userDto.id,
                        email = userDto.email,
                        firstName = userDto.firstName,
                        lastName = userDto.lastName, bio = null, phone = null,
                    )
                }
                localSource.updateOrCreate(users)
                Result.Success(Unit)
            }
            is Result.Error -> Result.Error(result.error)
        }
    }

    override suspend fun getUser(id: String): Flow<Result<User>> = flow {
        val localResult = localSource.getUser(id)
            ?.let(UserEntity::asDomain)
            ?.let { Result.Success(it) }

        if (localResult != null)
            emit(localResult)

        val remoteResult = remoteSource.getUser(id).map(UserDto::asDomain)

        emit(remoteResult)

        if (remoteResult is Result.Success)
            localSource.updateOrCreate(remoteResult.data.asEntity)
    }

    override suspend fun getUserPagingRemote(parameters: UserPagingParameters): Result<UserPagingResult> =
        remoteSource
            .getUsers(parameters.asRequest)
            .map(UserPagingDto::asDomain)

    override suspend fun getUserPagingLocal(parameters: UserPagingParameters): Flow<UserPagingResult> =
        localSource.gePagingCache(parameters.asRequest)
            .map { users ->
                users.map {
                    UserPagingData(it.id, it.email, it.firstName ?: "", it.lastName ?: "")
                }
            }.map { userData ->
                val userCount = localSource.getPagingCacheCount().toInt()
                UserPagingResult(
                    userData,
                    userCount,
                    parameters.limit,
                    parameters.offset
                )
            }

    override suspend fun updateUserPagingCache(users: List<UserPagingData>) {
        localSource.updatePagingCache(users.map(UserPagingData::asUserCache))
    }

    override suspend fun replaceLocalCacheWith(users: List<UserPagingData>) {
        localSource.replaceCacheWith(users.map(UserPagingData::asUserCache))
    }

    override suspend fun localCacheChanges(): Flow<Unit> = localSource.onPagingCacheChanged()

    override suspend fun updateUser(parameters: UserUpdateParameters): Result<User> = remoteSource
        .updateUser(parameters.userId, parameters.asRequest)
        .map(UserDto::asDomain)
        .also { result -> // update local data
            if (result is Result.Success)
                localSource.updateOrCreate(result.data.asEntity)
        }
}