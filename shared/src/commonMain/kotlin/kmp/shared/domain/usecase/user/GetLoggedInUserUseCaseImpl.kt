package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseFlowResultNoParams
import kmp.shared.domain.model.User
import kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetLoggedInUserUseCase : UseCaseFlowResultNoParams<User>

internal class GetLoggedInUserUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetLoggedInUserUseCase {
    override suspend fun invoke(): Flow<Result<User>> = userRepository.getUser()
}
