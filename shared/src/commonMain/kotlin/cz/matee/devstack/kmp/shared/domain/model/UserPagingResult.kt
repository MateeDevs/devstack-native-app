package cz.matee.devstack.kmp.shared.domain.model

import cz.matee.devstack.kmp.shared.infrastructure.local.UserCache

data class UserPagingResult(
    val users: List<UserPagingData>,
    val totalCount: Int,
    val limit: Int,
    val offset: Int
)

data class UserPagingData(
    val id: String,
    val email: String,
    val firstName: String?,
    val lastName: String?
) {
    val asUserCache get() = UserCache(id, email, firstName, lastName)
}