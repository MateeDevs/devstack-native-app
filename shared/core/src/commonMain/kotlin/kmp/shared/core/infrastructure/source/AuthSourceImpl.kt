package kmp.shared.core.infrastructure.source

import kmp.shared.core.base.Result
import kmp.shared.core.data.source.AuthSource
import kmp.shared.core.data.source.LoginRequest
import kmp.shared.core.data.source.RegistrationRequest
import kmp.shared.core.infrastructure.local.AuthDao
import kmp.shared.core.infrastructure.model.LoginDto
import kmp.shared.core.infrastructure.model.RegistrationDto
import kmp.shared.core.infrastructure.remote.AuthService

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
