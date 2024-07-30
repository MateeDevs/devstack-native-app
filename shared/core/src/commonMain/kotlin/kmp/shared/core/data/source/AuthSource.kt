package kmp.shared.core.data.source

import kmp.shared.core.base.Result
import kmp.shared.core.infrastructure.model.LoginDto
import kmp.shared.core.infrastructure.model.RegistrationDto
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
    val pass: String,
)
