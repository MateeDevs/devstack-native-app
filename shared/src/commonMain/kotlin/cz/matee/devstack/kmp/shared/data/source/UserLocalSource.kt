package cz.matee.devstack.kmp.shared.data.source

import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity
import kotlinx.coroutines.flow.Flow

interface UserLocalSource {
    suspend fun getUsers(paging: UserPagingRequest): Flow<List<UserEntity>>
    suspend fun getUser(id: String): UserEntity?
    suspend fun getUserCount(): Long
    suspend fun updateOrCreate(userEntity: UserEntity)
    suspend fun updateOrCreate(users: List<UserEntity>)
}