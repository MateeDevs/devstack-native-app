package cz.matee.devstack.kmp.shared.infrastructure.model

data class LoginDto(
    val email: String,
    val token: String,
    val userId: String
)