package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

class UserCacheChangeFlowUseCase internal constructor(
    private val userRepository: UserRepository
) : UseCaseNoParams<Flow<Unit>>() {
    override suspend fun doWork(params: Unit): Flow<Unit> =
        userRepository.localCacheChanges()
}