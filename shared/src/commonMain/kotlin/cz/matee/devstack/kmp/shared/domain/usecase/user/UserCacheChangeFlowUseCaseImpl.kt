package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParamsImpl
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

interface UserCacheChangeFlowUseCase : UseCaseNoParams<Flow<Unit>>

class UserCacheChangeFlowUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : UseCaseNoParamsImpl<Flow<Unit>>(), UserCacheChangeFlowUseCase {
    override suspend fun doWork(params: Unit): Flow<Unit> =
        userRepository.localCacheChanges()
}