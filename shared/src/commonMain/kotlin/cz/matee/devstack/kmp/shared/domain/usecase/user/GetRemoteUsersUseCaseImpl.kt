package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.model.UserPagingResult
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface GetRemoteUsersUseCase : UseCaseResult<UserPagingParameters, UserPagingResult>

class GetRemoteUsersUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetRemoteUsersUseCase {

    override suspend fun invoke(params: UserPagingParameters): Result<UserPagingResult> =
        userRepository.getUserPagingRemote(
            UserPagingParameters(params.offset, params.limit),
        )
}
