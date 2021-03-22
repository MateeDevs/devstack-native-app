package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

class LoginUseCase internal constructor(
    private val authRepository: AuthRepository
) : UseCaseResult<LoginUseCase.Params, Unit>() {
    data class Params(val email: String, val password: String)

    override suspend fun doWork(params: Params): Result<Unit> =
        authRepository.login(params.email, params.password)
}