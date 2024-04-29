package kmp.shared.domain.usecase.user

import kmp.shared.base.usecase.UseCaseFlow
import kmp.shared.domain.model.UserPagingResult
import kmp.shared.domain.repository.UserPagingParameters
import kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface GetLocalUsersUseCase : UseCaseFlow<UserPagingParameters, UserPagingResult>

internal class GetLocalUsersUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : GetLocalUsersUseCase {

    override suspend fun invoke(params: UserPagingParameters): Flow<UserPagingResult> =
        userRepository.getUserPagingLocal(
            UserPagingParameters(params.offset, params.limit),
        )
}
