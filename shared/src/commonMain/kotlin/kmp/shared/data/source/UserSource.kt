package kmp.shared.data.source

import kmp.shared.base.Result
import kmp.shared.infrastructure.local.UserCache
import kmp.shared.infrastructure.local.UserEntity
import kmp.shared.infrastructure.model.UserDto
import kmp.shared.infrastructure.model.UserPagingDto
import kotlinx.coroutines.flow.Flow
import kotlinx.serialization.Serializable

internal interface UserRemoteSource {
    suspend fun getUsers(paging: UserPagingRequest): Result<UserPagingDto>
    suspend fun getUser(id: String): Result<UserDto>
    suspend fun updateUser(id: String, updateRequest: UserUpdateRequest): Result<UserDto>
}

internal interface UserLocalSource {
    suspend fun getUser(id: String): UserEntity?
    fun getUsers(): Flow<List<UserEntity>>
    suspend fun updateOrCreate(userEntity: UserEntity)
    suspend fun updateOrCreate(entities: List<UserEntity>)

    suspend fun replaceCacheWith(users: List<UserCache>)
    suspend fun gePagingCache(paging: UserPagingRequest): Flow<List<UserCache>>
    suspend fun getPagingCacheCount(): Long
    suspend fun updatePagingCache(users: List<UserCache>)
    suspend fun onPagingCacheChanged(): Flow<Unit>
}

internal data class UserPagingRequest(
    val offset: Int,
    val limit: Int,
)

@Serializable
internal data class UserUpdateRequest(
    val bio: String?,
    val firstName: String?,
    val lastName: String?,
    val pass: String?,
    val phone: String?,
)
