package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResult
import kmp.shared.core.domain.model.UserPagingData
import kmp.shared.core.domain.repository.UserRepository

interface ReplaceUserCacheWithUseCase : UseCaseResult<List<UserPagingData>, Unit>
internal class ReplaceUserCacheWithUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : ReplaceUserCacheWithUseCase {
    override suspend fun invoke(params: List<UserPagingData>): Result<Unit> =
        Result.Success(userRepository.replaceLocalCacheWith(params))
}
