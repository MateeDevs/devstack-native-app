package cz.matee.devstack.kmp.shared.domain.usecase

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class GetRemoteUsersUseCase(
    private val userRepository: UserRepository
) : UseCaseResult<UserPagingParameters, UserPaging>() {

    override suspend fun doWork(params: UserPagingParameters): Result<UserPaging> =
        userRepository.getUsersRemote(
            UserPagingParameters(params.page, params.limit)
        )

}