package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

class RegisterUseCase internal constructor(
    private val authRepository: AuthRepository
) : UseCaseResult<RegisterUseCase.Params, Unit>() {
    data class Params(
        val email: String,
        val firstName: String,
        val lastName: String,
        val password: String
    )

    override suspend fun doWork(params: Params): Result<Unit> =
        authRepository.register(params.email, params.firstName, params.lastName, params.password)
}
