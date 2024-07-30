package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResult
import kmp.shared.core.domain.model.UserPagingData
import kmp.shared.core.domain.repository.UserRepository

interface UpdateLocalUserCacheUseCase : UseCaseResult<List<UserPagingData>, Unit>
internal class UpdateLocalUserCacheUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : UpdateLocalUserCacheUseCase {
    override suspend fun invoke(params: List<UserPagingData>): Result<Unit> =
        Result.Success(userRepository.updateUserPagingCache(params))
}
