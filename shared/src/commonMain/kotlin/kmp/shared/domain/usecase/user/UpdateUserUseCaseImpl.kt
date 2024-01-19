package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResult
import kmp.shared.domain.model.User
import kmp.shared.domain.repository.UserRepository
import kmp.shared.domain.repository.UserUpdateParameters

interface UpdateUserUseCase : UseCaseResult<UserUpdateParameters, User>
internal class UpdateUserUseCaseImpl(
    private val userRepository: UserRepository,
) : UpdateUserUseCase {

    override suspend fun invoke(params: UserUpdateParameters): Result<User> =
        userRepository.updateUser(params)
}
