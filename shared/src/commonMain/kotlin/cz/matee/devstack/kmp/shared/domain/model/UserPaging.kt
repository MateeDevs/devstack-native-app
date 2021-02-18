package cz.matee.devstack.kmp.shared.domain.model

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
)