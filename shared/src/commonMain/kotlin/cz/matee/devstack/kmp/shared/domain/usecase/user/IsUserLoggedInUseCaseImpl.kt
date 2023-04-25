package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface IsUserLoggedInUseCase : UseCaseResultNoParams<Boolean>
class IsUserLoggedInUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : IsUserLoggedInUseCase {
    override suspend fun invoke(): Result<Boolean> =
        Result.Success(userRepository.isUserLoggedIn)
}
