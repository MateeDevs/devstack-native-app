package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface UserCacheChangeFlowUseCase : UseCaseResultNoParams<Flow<Unit>>

class UserCacheChangeFlowUseCaseImpl internal constructor(
    private val userRepository: UserRepository,
) : UserCacheChangeFlowUseCase {
    override suspend fun invoke(): Result<Flow<Unit>> =
        userRepository.localCacheChanges().resultsTo(Success)
}
