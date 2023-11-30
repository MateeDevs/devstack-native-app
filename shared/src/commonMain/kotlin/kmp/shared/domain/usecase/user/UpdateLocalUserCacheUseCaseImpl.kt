package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResult
import kmp.shared.domain.model.UserPagingData
import kmp.shared.domain.repository.UserRepository

interface UpdateLocalUserCacheUseCase : UseCaseResult<List<UserPagingData>, Unit>
internal class UpdateLocalUserCacheUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : UpdateLocalUserCacheUseCase {
    override suspend fun invoke(params: List<UserPagingData>): Result<Unit> =
        Result.Success(userRepository.updateUserPagingCache(params))
}
