package kmp.shared.core.domain.usecase.user

import kmp.shared.core.base.Result
import kmp.shared.core.base.usecase.UseCaseResult
import kmp.shared.core.data.source.UserPagingRequest
import kmp.shared.core.domain.repository.UserRepository

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
