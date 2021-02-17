package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class GetUserUseCase(
    private val userRepository: UserRepository
) : UseCaseResult<GetUserUseCase.Params, User>() {
    class Params(val userId: String)

    override suspend fun doWork(params: Params): Result<User> =
        userRepository.getUser(params.userId)

}