package cz.matee.devstack.kmp.shared.infrastructure.model

import kotlinx.serialization.Serializable

@Serializable
data class UserDto(
    val id: String,
    val email: String,
    val firstName: String = "",
    val lastName: String = "",
    val bio: String = "",
    val phone: String? = null
)