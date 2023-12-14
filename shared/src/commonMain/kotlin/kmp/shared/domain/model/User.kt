package kmp.shared.domain.model

data class User(
    val id: String,
    val email: String,
    val bio: String,
    val firstName: String,
    val lastName: String,
    val phone: String?,
)
