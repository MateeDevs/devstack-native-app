package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCase
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface ReplaceUserCacheWithUseCase : UseCase<List<UserPagingData>, Unit>
class ReplaceUserCacheWithUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : ReplaceUserCacheWithUseCase {
    override suspend fun invoke(params: List<UserPagingData>) {
        userRepository.replaceLocalCacheWith(params)
    }
}