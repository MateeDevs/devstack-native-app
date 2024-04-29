package kmp.shared.domain.usecase.user

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResult
import kmp.shared.data.source.UserPagingRequest
import kmp.shared.domain.repository.UserRepository

interface RefreshUsersUseCase : UseCaseResult<RefreshUsersUseCase.Params, Unit> {
    data class Params(val offset: Int, val limit: Int)
}

internal class RefreshUsersUseCaseImpl internal constructor(
    private val repository: UserRepository,
) : RefreshUsersUseCase {

    override suspend fun invoke(params: RefreshUsersUseCase.Params): Result<Unit> {
        return repository.refreshUsers(UserPagingRequest(params.offset, params.limit))
    }
}
