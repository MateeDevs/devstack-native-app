package kmp.shared.core.data.repository

import kmp.shared.core.base.Result
import kmp.shared.core.base.util.extension.toEmptyResult
import kmp.shared.core.data.source.AuthSource
import kmp.shared.core.data.source.LoginRequest
import kmp.shared.core.data.source.RegistrationRequest
import kmp.shared.core.domain.repository.AuthRepository

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
