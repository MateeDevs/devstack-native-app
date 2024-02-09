package kmp.shared.data.repository

import kmp.shared.base.Result
import kmp.shared.base.error.domain.CommonError
import kmp.shared.base.util.extension.map
import kmp.shared.data.source.UserLocalSource
import kmp.shared.data.source.UserPagingRequest
import kmp.shared.data.source.UserRemoteSource
import kmp.shared.data.store.UserStore
import kmp.shared.domain.model.User
import kmp.shared.domain.model.UserPagingData
import kmp.shared.domain.model.UserPagingResult
import kmp.shared.domain.repository.UserPagingParameters
import kmp.shared.domain.repository.UserRepository
import kmp.shared.extension.asDomain
import kmp.shared.extension.asUserCache
import kmp.shared.extension.getResultFlow
import kmp.shared.extension.toResult
import kmp.shared.infrastructure.local.AuthDao
import kmp.shared.infrastructure.local.UserEntity
import kmp.shared.infrastructure.local.isLoggedIn
import kmp.shared.infrastructure.model.UserPagingDto
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map
import org.mobilenativefoundation.store.store5.StoreWriteRequest

internal class UserRepositoryImpl(
    private val authDao: AuthDao,
    private val remoteSource: UserRemoteSource,
    private val localSource: UserLocalSource,
    private val userStore: UserStore,
) : UserRepository {

    override val isUserLoggedIn: Boolean
        get() = authDao.isLoggedIn

    override suspend fun getUser(): Flow<Result<User>> {
        val userId = authDao.retrieveUserId()
            ?: return flow { emit(Result.Error(CommonError.NoUserLoggedIn)) }
        return getUser(userId)
    }

    override fun getUser(id: String): Flow<Result<User>> =
        userStore
            .getResultFlow(id)

    override suspend fun updateUser(user: User): Result<Unit> =
        userStore
            .write(StoreWriteRequest.of(key = user.id, value = user))
            .toResult()

    override suspend fun refreshUsers(pagingRequest: UserPagingRequest): Result<Unit> {
        return when (val result = remoteSource.getUsers(pagingRequest)) {
            is Result.Success -> {
                val users = result.data.data.map { userDto ->
                    UserEntity(
                        id = userDto.id,
                        email = userDto.email,
                        firstName = userDto.firstName,
                        lastName = userDto.lastName,
                        bio = null,
                        phone = null,
                    )
                }
                localSource.updateOrCreate(users)
                Result.Success(Unit)
            }

            is Result.Error -> Result.Error(result.error)
        }
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
                    parameters.offset,
                )
            }

    override suspend fun updateUserPagingCache(users: List<UserPagingData>) {
        localSource.updatePagingCache(users.map(UserPagingData::asUserCache))
    }

    override suspend fun replaceLocalCacheWith(users: List<UserPagingData>) {
        localSource.replaceCacheWith(users.map(UserPagingData::asUserCache))
    }

    override suspend fun localCacheChanges(): Flow<Unit> = localSource.onPagingCacheChanged()

}
