package cz.matee.devstack.kmp.shared.infrastructure.source

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.data.source.AuthSource
import cz.matee.devstack.kmp.shared.data.source.LoginRequest
import cz.matee.devstack.kmp.shared.data.source.RegistrationRequest
import cz.matee.devstack.kmp.shared.infrastructure.model.LoginDto
import cz.matee.devstack.kmp.shared.infrastructure.model.RegistrationDto
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthService

class AuthSourceImpl(private val service: AuthService) : AuthSource {

    override suspend fun login(request: LoginRequest): Result<LoginDto> =
        service.login(request)

    override suspend fun register(request: RegistrationRequest): Result<RegistrationDto> =
        service.register(request)

}