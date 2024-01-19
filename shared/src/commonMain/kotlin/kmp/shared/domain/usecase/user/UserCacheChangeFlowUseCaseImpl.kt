package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResultNoParams
import kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface UserCacheChangeFlowUseCase : UseCaseResultNoParams<Flow<Unit>>

internal class UserCacheChangeFlowUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : UserCacheChangeFlowUseCase {
    override suspend fun invoke(): Result<Flow<Unit>> =
        Result.Success(userRepository.localCacheChanges())
}
