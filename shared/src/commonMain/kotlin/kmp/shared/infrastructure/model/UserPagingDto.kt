package kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
internal data class UserPagingDto(
    val `data`: List<UserPagingDataDto>,
    val totalCount: Int,
    val lastPage: Int,
    val limit: Int,
    val page: Int,
)

@Serializable
internal data class UserPagingDataDto(
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String,
)
