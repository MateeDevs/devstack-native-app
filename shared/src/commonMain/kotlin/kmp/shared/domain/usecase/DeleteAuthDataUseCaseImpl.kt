package kmp.shared.domain.usecase

import kmp.shared.base.usecase.UseCaseResultNoParams
import kmp.shared.domain.repository.AuthRepository

interface DeleteAuthDataUseCase : UseCaseResultNoParams<Unit>

class DeleteAuthDataUseCaseImpl internal constructor(
    private val authRepository: AuthRepository,
) : DeleteAuthDataUseCase {

    override suspend fun invoke() = authRepository.deleteUserData()
}
