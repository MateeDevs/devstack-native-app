package cz.matee.devstack.kmp.shared.domain.usecase.user

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository

interface RefreshUsersUseCase : UseCaseResult<RefreshUsersUseCase.Params, Unit> {
    data class Params(val offset: Int, val limit: Int)
}

class RefreshUsersUseCaseImpl internal constructor(
    private val repository: UserRepository,
) : RefreshUsersUseCase {

    override suspend fun invoke(params: RefreshUsersUseCase.Params): Result<Unit> {
        return repository.refreshUsers(UserPagingRequest(params.offset, params.limit))
    }
}
