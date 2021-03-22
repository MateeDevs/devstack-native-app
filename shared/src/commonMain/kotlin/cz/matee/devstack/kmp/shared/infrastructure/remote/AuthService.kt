package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.util.runCatchingAuthNetworkExceptions
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.data.source.LoginRequest
import cz.matee.devstack.kmp.shared.data.source.RegistrationRequest
import cz.matee.devstack.kmp.shared.infrastructure.model.LoginDto
import cz.matee.devstack.kmp.shared.infrastructure.model.RegistrationDto
import io.ktor.client.HttpClient
import io.ktor.client.request.*

internal object AuthPaths {
    private const val root = "/auth"
    const val login = "$root/login"
    const val registration = "$root/registration"
}

internal class AuthService(private val client: HttpClient) {


    suspend fun login(body: LoginRequest): Result<LoginDto> =
        runCatchingAuthNetworkExceptions {
            client.post<LoginDto>(
                path = AuthPaths.login,
                body = body
            ) resultsTo Success
        }


    suspend fun register(body: RegistrationRequest): Result<RegistrationDto> =
        runCatchingAuthNetworkExceptions {
            client.post<RegistrationDto>(
                path = AuthPaths.registration,
                body = body
            ) resultsTo Success
        }
}