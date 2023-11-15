package kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
internal data class RegistrationDto(
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String,
)
