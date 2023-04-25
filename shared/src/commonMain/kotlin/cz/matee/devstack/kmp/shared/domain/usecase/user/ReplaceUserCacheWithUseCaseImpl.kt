package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface ReplaceUserCacheWithUseCase : UseCaseResult<List<UserPagingData>, Unit>
class ReplaceUserCacheWithUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : ReplaceUserCacheWithUseCase {
    override suspend fun invoke(params: List<UserPagingData>): Result<Unit> =
        Result.Success(userRepository.replaceLocalCacheWith(params))
}
