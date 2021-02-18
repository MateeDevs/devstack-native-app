package cz.matee.devstack.kmp.android.users.data

import androidx.paging.PagingSource
import androidx.paging.PagingState
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.UserData
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.usecase.GetPagedUsersUseCase
import java.io.IOException

class UsersPagingSource(
    private val getPagedUsersUseCase: GetPagedUsersUseCase
) : PagingSource<Int, UserData>() {

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, UserData> {
        val loadParams = UserPagingParameters(params.key ?: 0, params.loadSize)
        return when (val res = getPagedUsersUseCase(loadParams)) {
            is Result.Success -> with(res.data) {
                LoadResult.Page(
                    users,
                    (page - 1).takeIf { it >= 0 },
                    (page + 1).takeIf { page != lastPage },
                    page * limit,
                    (totalCount - (page + 1) * limit).coerceAtLeast(0)
                )
            }

            is Result.Error -> LoadResult.Error(
                res.error.throwable
                    ?: IOException("Unable to load paged users")
            )
        }
    }

    override fun getRefreshKey(state: PagingState<Int, UserData>): Int? = 0
}