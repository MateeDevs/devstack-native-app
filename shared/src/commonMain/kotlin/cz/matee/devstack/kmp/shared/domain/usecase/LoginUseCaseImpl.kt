package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultImpl
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

interface LoginUseCase : UseCaseResult<LoginUseCase.Params, Unit> {
    data class Params(val email: String, val password: String)
}

class LoginUseCaseImpl internal constructor(
    private val authRepository: AuthRepository
) : UseCaseResultImpl<LoginUseCase.Params, Unit>(), LoginUseCase {

    override suspend fun doWork(params: LoginUseCase.Params): Result<Unit> =
        authRepository.login(params.email, params.password)
}