package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.usecase.UseCase
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class UpdateUserLocalUseCase(
    private val userRepository: UserRepository
) : UseCase<List<User>, Unit>() {
    override suspend fun doWork(params: List<User>) =
        userRepository.updateUsersLocal(params)
}