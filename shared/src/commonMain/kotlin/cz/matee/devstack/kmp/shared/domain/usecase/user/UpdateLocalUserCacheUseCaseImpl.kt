package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface UpdateLocalUserCacheUseCase : UseCaseResult<List<UserPagingData>, Unit>
class UpdateLocalUserCacheUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : UpdateLocalUserCacheUseCase {
    override suspend fun invoke(params: List<UserPagingData>): Result<Unit> =
        userRepository.updateUserPagingCache(params).resultsTo(Success)
}
