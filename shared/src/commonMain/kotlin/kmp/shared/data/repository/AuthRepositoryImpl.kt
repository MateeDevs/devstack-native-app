package kmp.shared.data.repository

import kmp.shared.base.Result
import kmp.shared.base.util.extension.toEmptyResult
import kmp.shared.data.source.AuthSource
import kmp.shared.data.source.LoginRequest
import kmp.shared.data.source.RegistrationRequest
import kmp.shared.domain.repository.AuthRepository

internal class AuthRepositoryImpl(private val source: AuthSource) : AuthRepository {
    override suspend fun login(email: String, pass: String): Result<Unit> = source
        .login(LoginRequest(email, pass))
        .toEmptyResult()

    override suspend fun register(
        email: String,
        firstName: String,
        lastName: String,
        pass: String,
    ): Result<Unit> = source
        .register(RegistrationRequest(email, firstName, lastName, pass))
        .toEmptyResult()

    override suspend fun deleteUserData(): Result<Unit> =
        source.deleteUserData()
}
