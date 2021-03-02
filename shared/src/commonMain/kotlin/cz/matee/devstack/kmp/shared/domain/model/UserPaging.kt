package cz.matee.devstack.kmp.shared.domain.model

import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity

data class UserPaging(
    val users: List<UserData>,
    val totalCount: Int,
    val lastPage: Int,
    val limit: Int,
    val page: Int
)

data class UserData(
    val id: String,
    val email: String,
    val firstName: String,
    val lastName: String
) {
    val asEntityWithPlaceholders: UserEntity
        get() = UserEntity(id, email, firstName, lastName, "", "")

    val asUserWithPlaceholders: User
        get() = User(id, email, "", firstName, lastName, "")
}