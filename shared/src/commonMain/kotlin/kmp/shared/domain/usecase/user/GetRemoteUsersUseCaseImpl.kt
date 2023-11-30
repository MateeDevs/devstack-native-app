package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResult
import kmp.shared.domain.model.UserPagingResult
import kmp.shared.domain.repository.UserPagingParameters
import kmp.shared.domain.repository.UserRepository

interface GetRemoteUsersUseCase : UseCaseResult<UserPagingParameters, UserPagingResult>

internal class GetRemoteUsersUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetRemoteUsersUseCase {

    override suspend fun invoke(params: UserPagingParameters): Result<UserPagingResult> =
        userRepository.getUserPagingRemote(
            UserPagingParameters(params.offset, params.limit),
        )
}
