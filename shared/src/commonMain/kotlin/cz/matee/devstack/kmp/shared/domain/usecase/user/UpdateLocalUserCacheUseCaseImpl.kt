package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCase
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface UpdateLocalUserCacheUseCase : UseCase<List<UserPagingData>, Unit>
class UpdateLocalUserCacheUseCaseImpl internal constructor(
    private val userRepository: UserRepository
) : UpdateLocalUserCacheUseCase {
    override suspend fun invoke(params: List<UserPagingData>) =
        userRepository.updateUserPagingCache(params)
}