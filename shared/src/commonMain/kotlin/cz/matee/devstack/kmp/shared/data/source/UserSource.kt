package cz.matee.devstack.kmp.shared.data.source

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.infrastructure.local.UserCache
import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto
import kotlinx.coroutines.flow.Flow
import kotlinx.serialization.Serializable

interface UserRemoteSource {
    suspend fun getUsers(paging: UserPagingRequest): Result<UserPagingDto>
    suspend fun getUser(id: String): Result<UserDto>
    suspend fun updateUser(id: String, updateRequest: UserUpdateRequest): Result<UserDto>
}

interface UserLocalSource {
    suspend fun getUser(id: String): UserEntity?
    suspend fun updateOrCreate(userEntity: UserEntity)

    suspend fun replaceCacheWith(users: List<UserCache>)
    suspend fun gePagingCache(paging: UserPagingRequest): Flow<List<UserCache>>
    suspend fun getPagingCacheCount(): Long
    suspend fun updatePagingCache(users: List<UserCache>)
    suspend fun onPagingCacheChanged(): Flow<Unit>
}

data class UserPagingRequest(
    val offset: Int,
    val limit: Int
)

@Serializable
data class UserUpdateRequest(
    val bio: String?,
    val firstName: String?,
    val lastName: String?,
    val pass: String?,
    val phone: String?
)