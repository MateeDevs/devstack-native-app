package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResult
import kmp.shared.core.domain.model.User
import kmp.shared.core.domain.repository.UserRepository
import kmp.shared.core.domain.repository.UserUpdateParameters

interface UpdateUserUseCase : UseCaseResult<UserUpdateParameters, User>
internal class UpdateUserUseCaseImpl(
    private val userRepository: UserRepository,
) : UpdateUserUseCase {

    override suspend fun invoke(params: UserUpdateParameters): Result<User> =
        userRepository.updateUser(params)
}
