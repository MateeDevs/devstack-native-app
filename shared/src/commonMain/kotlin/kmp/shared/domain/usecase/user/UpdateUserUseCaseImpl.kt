package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResult
import kmp.shared.domain.model.User
import kmp.shared.domain.repository.UserRepository

interface UpdateUserUseCase : UseCaseResult<User, Unit>
internal class UpdateUserUseCaseImpl(
    private val userRepository: UserRepository,
) : UpdateUserUseCase {

    override suspend fun invoke(params: User): Result<Unit> = userRepository.updateUser(params)
}
