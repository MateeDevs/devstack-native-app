package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResultNoParams
import kmp.shared.core.domain.repository.UserRepository

interface IsUserLoggedInUseCase : UseCaseResultNoParams<Boolean>
internal class IsUserLoggedInUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : IsUserLoggedInUseCase {
    override suspend fun invoke(): Result<Boolean> =
        Result.Success(userRepository.isUserLoggedIn)
}
