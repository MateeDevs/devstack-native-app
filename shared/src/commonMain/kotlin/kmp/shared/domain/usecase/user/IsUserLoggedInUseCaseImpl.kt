package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResultNoParams
import kmp.shared.domain.repository.UserRepository

interface IsUserLoggedInUseCase : UseCaseResultNoParams<Boolean>
internal class IsUserLoggedInUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : IsUserLoggedInUseCase {
    override suspend fun invoke(): Result<Boolean> =
        Result.Success(userRepository.isUserLoggedIn)
}
