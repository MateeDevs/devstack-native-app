package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResult
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResultImpl
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetUserUseCase : UseCaseFlowResult<GetUserUseCase.Params, User> {
    class Params(val userId: String)
}

class GetUserUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : UseCaseFlowResultImpl<GetUserUseCase.Params, User>(), GetUserUseCase {
    override suspend fun doWork(params: GetUserUseCase.Params): Flow<Result<User>> =
        userRepository.getUser(params.userId)
}