package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface IsUserLoggedInUseCase : UseCaseNoParams<Boolean>
class IsUserLoggedInUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : UseCaseNoParamsImpl<Boolean>(), IsUserLoggedInUseCase {
    override suspend fun doWork(params: Unit): Boolean = userRepository.isUserLoggedIn
}