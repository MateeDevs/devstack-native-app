package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository

interface DeleteAuthDataUseCase : UseCaseResultNoParams<Unit>

class DeleteAuthDataUseCaseImpl internal constructor(
    private val authRepository: AuthRepository
) : UseCaseResultNoParamsImpl<Unit>(), DeleteAuthDataUseCase {

    override suspend fun doWork(params: Unit): Result<Unit> =
        authRepository.deleteUserData()
}