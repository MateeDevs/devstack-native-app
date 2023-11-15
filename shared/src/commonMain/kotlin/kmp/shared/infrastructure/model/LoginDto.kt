package kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
internal data class LoginDto(
    val email: String,
    val token: String,
    val userId: String,
)
