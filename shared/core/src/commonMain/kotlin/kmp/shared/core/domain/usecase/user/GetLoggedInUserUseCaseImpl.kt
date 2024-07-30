package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseFlowResultNoParams
import kmp.shared.core.domain.model.User
import kmp.shared.core.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetLoggedInUserUseCase : UseCaseFlowResultNoParams<User>

internal class GetLoggedInUserUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetLoggedInUserUseCase {
    override suspend fun invoke(): Flow<Result<User>> = userRepository.getUser()
}
