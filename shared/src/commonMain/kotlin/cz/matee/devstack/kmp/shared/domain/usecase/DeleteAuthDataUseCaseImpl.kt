package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

interface DeleteAuthDataUseCase : UseCaseResultNoParams<Unit>

class DeleteAuthDataUseCaseImpl internal constructor(
    private val authRepository: AuthRepository,
) : DeleteAuthDataUseCase {

    override suspend fun invoke() = authRepository.deleteUserData()
}
