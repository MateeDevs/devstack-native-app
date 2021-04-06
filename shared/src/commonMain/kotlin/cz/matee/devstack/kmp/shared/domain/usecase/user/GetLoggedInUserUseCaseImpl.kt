package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResultNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResultNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetLoggedInUserUseCase : UseCaseFlowResultNoParams<User>

class GetLoggedInUserUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : UseCaseFlowResultNoParamsImpl<User>(), GetLoggedInUserUseCase {
    override suspend fun doWork(params: Unit): Flow<Result<User>> = userRepository.getUser()
}