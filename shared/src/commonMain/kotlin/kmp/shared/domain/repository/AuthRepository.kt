package kmp.shared.domain.repository

import kmp.shared.base.Result

internal interface AuthRepository {
    suspend fun login(email: String, pass: String): Result<Unit>
    suspend fun register(
        email: String,
        firstName: String,
        lastName: String,
        pass: String,
    ): Result<Unit>

    suspend fun deleteUserData(): Result<Unit>
}
