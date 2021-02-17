package cz.matee.devstack.kmp.shared.data.source

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto

interface UserRemoteSource {
    suspend fun getUsers(paging: UserPagingRequest): Result<UserPagingDto>
    suspend fun getUser(id: String): Result<UserDto>
    suspend fun updateUser(id: String, updateRequest: UserUpdateRequest): Result<UserDto>
}

data class UserPagingRequest(
    val page: Int,
    val limit: Int
)

data class UserUpdateRequest(
    val bio: String?,
    val firstName: String?,
    val lastName: String?,
    val pass: String?,
    val phone: String?
)