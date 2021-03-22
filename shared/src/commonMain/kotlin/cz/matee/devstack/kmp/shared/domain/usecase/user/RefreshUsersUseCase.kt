package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

class RefreshUsersUseCase internal constructor(
    private val repository: UserRepository
) : UseCaseResult<RefreshUsersUseCase.Params, Unit>() {

    override suspend fun doWork(params: Params): Result<Unit> {
        return repository.refreshUsers(UserPagingRequest(params.offset, params.limit))
    }

    data class Params(val offset: Int, val limit: Int)
}