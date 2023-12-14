package kmp.shared.domain.model

data class UserPagingResult(
    val users: List<UserPagingData>,
    val totalCount: Int,
    val limit: Int,
    val offset: Int,
)

data class UserPagingData(
    val id: String,
    val email: String,
    val firstName: String?,
    val lastName: String?,
)
