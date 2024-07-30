package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResult
import kmp.shared.core.domain.model.UserPagingResult
import kmp.shared.core.domain.repository.UserPagingParameters
import kmp.shared.core.domain.repository.UserRepository

interface GetRemoteUsersUseCase : UseCaseResult<UserPagingParameters, UserPagingResult>

internal class GetRemoteUsersUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetRemoteUsersUseCase {

    override suspend fun invoke(params: UserPagingParameters): Result<UserPagingResult> =
        userRepository.getUserPagingRemote(
            UserPagingParameters(params.offset, params.limit),
        )
}
