package cz.matee.devstack.kmp.shared.domain.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.data.source.UserUpdateRequest
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserPaging

interface UserRepository {
    val isUserLoggedIn: Boolean
    suspend fun getUser(): Result<User>
    suspend fun getUser(id: String): Result<User>
    suspend fun getUsers(parameters: UserPagingParameters): Result<UserPaging>
    suspend fun updateUser(parameters: UserUpdateParameters): Result<User>
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