package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface IsUserLoggedInUseCase : UseCaseResultNoParams<Boolean>
class IsUserLoggedInUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : IsUserLoggedInUseCase {
    override suspend fun invoke(): Result<Boolean> =
        userRepository.isUserLoggedIn.resultsTo(Success)
}
