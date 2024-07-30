package kmp.shared.core.infrastructure.remote

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.post
import io.ktor.client.request.setBody
import kmp.shared.core.base.Result
import kmp.shared.core.base.error.util.runCatchingAuthNetworkExceptions
import kmp.shared.core.data.source.LoginRequest
import kmp.shared.core.data.source.RegistrationRequest
import kmp.shared.core.infrastructure.model.LoginDto
import kmp.shared.core.infrastructure.model.RegistrationDto

internal object AuthPaths {
    private const val root = "/api/auth"
    const val login = "$root/login"
    const val registration = "$root/registration"
}

internal class AuthService(private val client: HttpClient) {

    suspend fun login(body: LoginRequest): Result<LoginDto> =
        runCatchingAuthNetworkExceptions {
            client.post(AuthPaths.login) {
                setBody(body)
            }.body()
        }

    suspend fun register(body: RegistrationRequest): Result<RegistrationDto> =
        runCatchingAuthNetworkExceptions {
            client.post(AuthPaths.registration) {
                setBody(body)
            }.body()
        }
}
