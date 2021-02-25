package cz.matee.devstack.kmp.shared.infrastructure.model

import cz.matee.devstack.kmp.shared.domain.model.User
import kotlinx.serialization.Serializable

@Serializable
data class UserDto(
    val id: String,
    val email: String,
    val firstName: String = "",
    val lastName: String = "",
    val bio: String = "",
    val phone: String? = null
) {
    val asDomain get() = User(id, email, bio, firstName, lastName, phone)
}