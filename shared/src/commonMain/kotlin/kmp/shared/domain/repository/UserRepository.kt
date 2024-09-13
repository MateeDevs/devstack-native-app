package kmp.shared.domain.repository

import kmp.shared.base.Result
import kmp.shared.data.source.UserPagingRequest
import kmp.shared.domain.model.User
import kmp.shared.domain.model.UserPagingData
import kmp.shared.domain.model.UserPagingResult
import kotlinx.coroutines.flow.Flow

internal interface UserRepository {
    val isUserLoggedIn: Boolean
    suspend fun getUser(): Flow<Result<User>>
    fun getUser(id: String): Flow<Result<User>>
    suspend fun updateUser(user: User): Result<Unit>

    suspend fun refreshUsers(pagingRequest: UserPagingRequest): Result<Unit>
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
