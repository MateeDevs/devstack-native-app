package cz.matee.devstack.kmp.shared.domain.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.data.source.UserUpdateRequest
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
import kotlinx.coroutines.flow.Flow

interface UserRepository {
    val isUserLoggedIn: Boolean
    suspend fun getUser(): Flow<Result<User>>
    suspend fun getUser(id: String): Flow<Result<User>>
    suspend fun updateUser(parameters: UserUpdateParameters): Result<User>

    suspend fun getUsersRemote(parameters: UserPagingParameters): Result<UserPaging>
    suspend fun getUsersLocal(parameters: UserPagingParameters): Flow<UserPaging>
    suspend fun updateUsersLocal(users: List<User>)
}

data class UserPagingParameters(
    val page: Int,
    val limit: Int
) {
    val asRequest
        get() = UserPagingRequest(
            page, limit
        )
}

data class UserUpdateParameters(
    val userId: String,
    val bio: String? = null,
    val firstName: String? = null,
    val lastName: String? = null,
    val pass: String? = null,
    val phone: String? = null
) {
    val asRequest
        get() = UserUpdateRequest(
            bio, firstName, lastName, pass, phone
        )
}