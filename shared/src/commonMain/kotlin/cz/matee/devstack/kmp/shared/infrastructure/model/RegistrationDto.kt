package cz.matee.devstack.kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
data class RegistrationDto(
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String
)