package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.usecase.UseCase
import cz.matee.devstack.kmp.shared.domain.model.UserPagingResult
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

class GetLocalUsersUseCase internal constructor(
    private val userRepository: UserRepository
) : UseCase<UserPagingParameters, Flow<UserPagingResult>>() {

    override suspend fun doWork(params: UserPagingParameters): Flow<UserPagingResult> =
        userRepository.getUserPagingLocal(
            UserPagingParameters(params.offset, params.limit)
        )
}