package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlow
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowImpl
import cz.matee.devstack.kmp.shared.domain.model.UserPagingResult
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetLocalUsersUseCase : UseCaseFlow<UserPagingParameters, UserPagingResult>

class GetLocalUsersUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : UseCaseFlowImpl<UserPagingParameters, UserPagingResult>(), GetLocalUsersUseCase {

    override suspend fun doWork(params: UserPagingParameters): Flow<UserPagingResult> =
        userRepository.getUserPagingLocal(
            UserPagingParameters(params.offset, params.limit)
        )
}