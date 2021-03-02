package cz.matee.devstack.kmp.shared.data.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.base.util.extension.map
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.data.source.UserLocalSource
import cz.matee.devstack.kmp.shared.data.source.UserRemoteSource
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserData
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
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
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map
import kotlin.math.ceil

class UserRepositoryImpl(
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

    override suspend fun getUser(id: String): Flow<Result<User>> = flow {
        localSource.getUser(id)
            ?.let(UserEntity::asDomain)
            ?.resultsTo(Success)
            ?.let { emit(it) }

        val remoteResult = remoteSource.getUser(id).map(UserDto::asDomain)
        emit(remoteResult)

        if (remoteResult is Result.Success)
            localSource.updateOrCreate(remoteResult.data.asEntity)
    }

    override suspend fun getUsersRemote(parameters: UserPagingParameters): Result<UserPaging> =
        remoteSource
            .getUsers(parameters.asRequest)
            .map(UserPagingDto::asDomain)
            .also { result ->
                if (result is Result.Success)
                    localSource.updateOrCreate(result.data.users.map(UserData::asEntityWithPlaceholders))
            }

    override suspend fun getUsersLocal(parameters: UserPagingParameters): Flow<UserPaging> =
        localSource.getUsers(parameters.asRequest)
            .map { users ->
                users.map {
                    UserData(it.id, it.email, it.firstName ?: "", it.lastName ?: "")
                }
            }.map { userData ->
                val userCount = localSource.getUserCount().toInt()
                UserPaging(
                    userData,
                    userCount,
                    // Round to upper bound and decrement to get last page (indexed from zero)
                    // Example: total = 10, limit = 3 -> lastPage = 3 ; total = 9, limit = 3 -> lasPage = 2
                    ceil((userCount.toFloat() / parameters.limit)).toInt() - 1,
                    parameters.limit,
                    parameters.page
                )
            }

    override suspend fun updateUser(parameters: UserUpdateParameters): Result<User> = remoteSource
        .updateUser(parameters.userId, parameters.asRequest)
        .map(UserDto::asDomain)
        .also { result -> // update local data
            if (result is Result.Success)
                localSource.updateOrCreate(result.data.asEntity)
        }

    override suspend fun updateUsersLocal(users: List<User>) {
        localSource.updateOrCreate(users.map(User::asEntity))
    }

}