package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCase
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class ReplaceUserCacheWithUseCase internal constructor(
    private val userRepository: UserRepository
) : UseCase<List<UserPagingData>, Unit>() {
    override suspend fun doWork(params: List<UserPagingData>) {
        userRepository.replaceLocalCacheWith(params)
    }
}