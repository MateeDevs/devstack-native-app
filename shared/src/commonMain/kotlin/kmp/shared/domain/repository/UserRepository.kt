package kmp.shared.domain.repository

import kmp.shared.base.Result
import kmp.shared.data.source.UserPagingRequest
import kmp.shared.data.source.UserUpdateRequest
import kmp.shared.domain.model.User
import kmp.shared.domain.model.UserPagingData
import kmp.shared.domain.model.UserPagingResult
import kotlinx.coroutines.flow.Flow

internal interface UserRepository {
    val isUserLoggedIn: Boolean
    suspend fun getUser(): Flow<Result<User>>
    fun getUsers(): Flow<List<User>>
    suspend fun getUser(id: String): Flow<Result<User>>
    suspend fun refreshUsers(pagingRequest: UserPagingRequest): Result<Unit>
    suspend fun updateUser(parameters: UserUpdateParameters): Result<User>

    suspend fun getUserPagingRemote(parameters: UserPagingParameters): Result<UserPagingResult>
    suspend fun getUserPagingLocal(parameters: UserPagingParameters): Flow<UserPagingResult>
    suspend fun updateUserPagingCache(users: List<UserPagingData>)
    suspend fun replaceLocalCacheWith(users: List<UserPagingData>)
    suspend fun localCacheChanges(): Flow<Unit>
}

data class UserPagingParameters(
    val offset: Int,
    val limit: Int,
) {
    internal val asRequest
        get() = UserPagingRequest(
            offset,
            limit,
        )
}

data class UserUpdateParameters(
    val userId: String,
    val bio: String? = null,
    val firstName: String? = null,
    val lastName: String? = null,
    val pass: String? = null,
    val phone: String? = null,
) {
    internal val asRequest
        get() = UserUpdateRequest(
            bio,
            firstName,
            lastName,
            pass,
            phone,
        )
}
