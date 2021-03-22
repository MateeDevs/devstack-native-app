package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

class DeleteAuthDataUseCase internal constructor(
    private val authRepository: AuthRepository
) : UseCaseResultNoParams<Unit>() {

    override suspend fun doWork(params: Unit): Result<Unit> =
        authRepository.deleteUserData()
}