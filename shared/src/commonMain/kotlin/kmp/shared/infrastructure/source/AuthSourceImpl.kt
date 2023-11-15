package kmp.shared.infrastructure.source

import kmp.shared.base.Result
import kmp.shared.data.source.AuthSource
import kmp.shared.data.source.LoginRequest
import kmp.shared.data.source.RegistrationRequest
import kmp.shared.infrastructure.local.AuthDao
import kmp.shared.infrastructure.model.LoginDto
import kmp.shared.infrastructure.model.RegistrationDto
import kmp.shared.infrastructure.remote.AuthService

internal class AuthSourceImpl(
    private val service: AuthService,
    private val authDao: AuthDao,
) : AuthSource {

    override suspend fun login(request: LoginRequest): Result<LoginDto> =
        service.login(request)

    override suspend fun register(request: RegistrationRequest): Result<RegistrationDto> =
        service.register(request)

    override suspend fun deleteUserData(): Result<Unit> =
        Result.Success(authDao.wipeData())
}
