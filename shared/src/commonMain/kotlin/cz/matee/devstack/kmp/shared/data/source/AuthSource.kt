package cz.matee.devstack.kmp.shared.data.source

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.infrastructure.model.LoginDto
import cz.matee.devstack.kmp.shared.infrastructure.model.RegistrationDto
import kotlinx.serialization.Serializable

internal interface AuthSource {
    suspend fun login(request: LoginRequest): Result<LoginDto>
    suspend fun register(request: RegistrationRequest): Result<RegistrationDto>
    suspend fun deleteUserData(): Result<Unit>
}

@Serializable
internal data class LoginRequest(val email: String, val pass: String)

@Serializable
internal data class RegistrationRequest(
    val email: String,
    val firstName: String,
    val lastName: String,
    val pass: String
)