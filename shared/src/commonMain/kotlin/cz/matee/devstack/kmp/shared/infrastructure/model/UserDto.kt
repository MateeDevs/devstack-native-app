package cz.matee.devstack.kmp.shared.infrastructure.model

import cz.matee.devstack.kmp.shared.domain.model.User
import kotlinx.serialization.Serializable

@Serializable
data class UserDto(
    val bio: String,
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String,
    val phone: String
) {
    val asDomain get() = User(id, email, bio, firstName, lastName, phone)
}