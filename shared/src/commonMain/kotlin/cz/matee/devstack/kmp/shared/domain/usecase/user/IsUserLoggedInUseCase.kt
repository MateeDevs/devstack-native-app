package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class IsUserLoggedInUseCase(
    private val userRepository: UserRepository
) : UseCaseNoParams<Boolean>() {
    override suspend fun doWork(params: Unit): Boolean = userRepository.isUserLoggedIn
}