package cz.matee.devstack.kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
data class UserPagingDto(
    val `data`: List<UserPagingDataDto>,
    val totalCount: Int,
    val lastPage: Int,
    val limit: Int,
    val page: Int
)

@Serializable
data class UserPagingDataDto(
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String
)