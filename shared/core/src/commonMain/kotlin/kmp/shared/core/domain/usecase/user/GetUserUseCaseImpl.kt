package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseFlowResult
import kmp.shared.core.domain.model.User
import kmp.shared.core.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetUserUseCase : UseCaseFlowResult<GetUserUseCase.Params, User> {
    class Params(val userId: String)
}

internal class GetUserUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetUserUseCase {
    override suspend fun invoke(params: GetUserUseCase.Params): Flow<Result<User>> =
        userRepository.getUser(params.userId)
}
