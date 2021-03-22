package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResult
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

class GetUserUseCase internal constructor(
    private val userRepository: UserRepository
) : UseCaseFlowResult<GetUserUseCase.Params, User>() {
    class Params(val userId: String)

    override suspend fun doWork(params: Params): Flow<Result<User>> =
        userRepository.getUser(params.userId)
}