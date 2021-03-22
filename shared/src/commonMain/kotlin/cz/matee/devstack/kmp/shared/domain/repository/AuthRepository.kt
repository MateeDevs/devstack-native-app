package cz.matee.devstack.kmp.shared.domain.repository

import cz.matee.devstack.kmp.shared.base.Result

internal interface AuthRepository {
    suspend fun login(email: String, pass: String): Result<Unit>
    suspend fun register(
        email: String,
        firstName: String,
        lastName: String,
        pass: String
    ): Result<Unit>

    suspend fun deleteUserData(): Result<Unit>
}