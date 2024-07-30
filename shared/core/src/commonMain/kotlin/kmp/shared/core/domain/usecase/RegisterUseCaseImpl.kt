package kmp.shared.core.domain.usecase

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResult
import kmp.shared.core.domain.repository.AuthRepository

interface RegisterUseCase : UseCaseResult<RegisterUseCase.Params, Unit> {
    data class Params(
        val email: String,
        val firstName: String,
        val lastName: String,
        val password: String,
    )
}

internal class RegisterUseCaseImpl internal constructor(
    private val authRepository: AuthRepository,
) : RegisterUseCase {

    override suspend fun invoke(params: RegisterUseCase.Params): Result<Unit> =
        authRepository.register(params.email, params.firstName, params.lastName, params.password)
}
