package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.infrastructure.model.LoginDto
import io.ktor.client.HttpClient
import io.ktor.client.request.*

class AuthService(private val client: HttpClient) {

    data class LoginRequest(val email: String, val pass: String)

    suspend fun login(body: LoginRequest) =
        client.get<LoginDto>("/auth/login", body = body)
}