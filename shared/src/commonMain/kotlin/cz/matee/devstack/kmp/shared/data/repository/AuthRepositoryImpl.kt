package cz.matee.devstack.kmp.shared.data.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.util.extension.toEmptyResult
import cz.matee.devstack.kmp.shared.data.source.AuthSource
import cz.matee.devstack.kmp.shared.data.source.LoginRequest
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

internal class AuthRepositoryImpl(private val source: AuthSource) : AuthRepository {
    override suspend fun login(email: String, pass: String): Result<Unit> =
        source.login(LoginRequest(email, pass)).toEmptyResult()

    override suspend fun register(
        email: String,
        firstName: String,
        lastName: String,
        pass: String
    ): Result<Unit> {
        TODO("Not yet implemented")
    }
}