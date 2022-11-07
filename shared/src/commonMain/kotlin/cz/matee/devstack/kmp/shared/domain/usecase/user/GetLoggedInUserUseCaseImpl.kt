package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResultNoParams
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetLoggedInUserUseCase : UseCaseFlowResultNoParams<User>

class GetLoggedInUserUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : GetLoggedInUserUseCase {
    override suspend fun invoke(): Flow<Result<User>> = userRepository.getUser()
}