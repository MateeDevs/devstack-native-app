package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface IsUserLoggedInUseCase : UseCaseNoParams<Boolean>
class IsUserLoggedInUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : IsUserLoggedInUseCase {
    override suspend fun invoke(): Boolean = userRepository.isUserLoggedIn
}