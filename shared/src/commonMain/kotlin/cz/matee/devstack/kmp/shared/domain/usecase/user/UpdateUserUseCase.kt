package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import cz.matee.devstack.kmp.shared.domain.repository.UserUpdateParameters

class UpdateUserUseCase internal constructor(
    private val userRepository: UserRepository
) : UseCaseResult<UserUpdateParameters, User>() {

    override suspend fun doWork(params: UserUpdateParameters): Result<User> =
        userRepository.updateUser(params)
}