package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.usecase.UseCase
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import kotlinx.coroutines.flow.Flow

class GetLocalUsersUseCase(
    private val userRepository: UserRepository
) : UseCase<UserPagingParameters, Flow<UserPaging>>() {

    override suspend fun doWork(params: UserPagingParameters): Flow<UserPaging> =
        userRepository.getUsersLocal(
            UserPagingParameters(params.page, params.limit)
        )
}