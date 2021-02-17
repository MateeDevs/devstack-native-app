package cz.matee.devstack.kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
data class LoginDto(
    val email: String,
    val token: String,
    val userId: String
)