package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class GetLoggedInUserUseCase(
    private val userRepository: UserRepository
) : UseCaseResultNoParams<User>() {
    override suspend fun doWork(params: Unit): Result<User> = userRepository.getUser()
}