package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseFlowResult
import kmp.shared.domain.model.User
import kmp.shared.domain.repository.UserRepository
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
