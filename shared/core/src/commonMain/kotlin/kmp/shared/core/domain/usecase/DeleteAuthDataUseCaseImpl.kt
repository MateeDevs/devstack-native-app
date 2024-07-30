package kmp.shared.core.domain.usecase

import kmp.shared.core.base.usecase.UseCaseResultNoParams
import kmp.shared.core.domain.repository.AuthRepository

interface DeleteAuthDataUseCase : UseCaseResultNoParams<Unit>

internal class DeleteAuthDataUseCaseImpl internal constructor(
    private val authRepository: AuthRepository,
) : DeleteAuthDataUseCase {

    override suspend fun invoke() = authRepository.deleteUserData()
}
