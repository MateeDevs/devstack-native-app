package cz.matee.devstack.kmp.shared.data.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.base.util.extension.map
import cz.matee.devstack.kmp.shared.data.source.UserRemoteSource
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import cz.matee.devstack.kmp.shared.domain.repository.UserUpdateParameters
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.infrastructure.local.isLoggedIn
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto

class UserRepositoryImpl(
    private val authDao: AuthDao,
    private val remoteSource: UserRemoteSource
) : UserRepository {

    override val isUserLoggedIn: Boolean
        get() = authDao.isLoggedIn

    override suspend fun getUser(): Result<User> {
        val userId = authDao.retrieveUserId()
            ?: return Result.Error(CommonError.NoUserLoggedIn)
        return getUser(userId)
    }

    override suspend fun getUser(id: String): Result<User> = remoteSource
        .getUser(id)
        .map(UserDto::asDomain)

    override suspend fun getUsers(parameters: UserPagingParameters): Result<UserPaging> =
        remoteSource
            .getUsers(parameters.asRequest)
            .map(UserPagingDto::asDomain)

    override suspend fun updateUser(parameters: UserUpdateParameters): Result<User> = remoteSource
        .updateUser(parameters.userId, parameters.asRequest)
        .map(UserDto::asDomain)

}