package kmp.shared.domain.usecase

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResult
import kmp.shared.domain.repository.AuthRepository

interface LoginUseCase : UseCaseResult<LoginUseCase.Params, Unit> {
    data class Params(val email: String, val password: String)
}

internal class LoginUseCaseImpl internal constructor(
    private val authRepository: AuthRepository,
) : LoginUseCase {

    override suspend fun invoke(params: LoginUseCase.Params): Result<Unit> =
        authRepository.login(params.email, params.password)
}
