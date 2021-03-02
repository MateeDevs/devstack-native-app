package cz.matee.devstack.kmp.android.users.data

import android.util.Log
import androidx.paging.*
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.UserData
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.usecase.GetLocalUsersUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.GetRemoteUsersUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.UpdateUserLocalUseCase
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.drop
import kotlinx.coroutines.flow.first
import kotlin.coroutines.CoroutineContext

class UsersPagingSource(
    private val getLocalUsers: GetLocalUsersUseCase
) : PagingSource<Int, UserData>(), CoroutineScope {
    override val coroutineContext: CoroutineContext = Job() + Dispatchers.IO

    private val invalidatedCallback: () -> Unit = {
        Log.d("LOAD_LOCAL", "INVALIDATED")
        coroutineContext.cancel()
    }

    init {
        registerInvalidatedCallback(invalidatedCallback)
        coroutineContext.job.invokeOnCompletion {
            unregisterInvalidatedCallback(invalidatedCallback)
            invalidate()
        }
    }

    override suspend fun load(params: LoadParams<Int>): LoadResult<Int, UserData> {
        val loadParams = UserPagingParameters(params.key ?: 0, params.loadSize)
        Log.d("LOAD_LOCAL", loadParams.toString())

        val userFlow = getLocalUsers(loadParams)
        invalidateOnChange(userFlow)

        val res = userFlow.first()
        return with(res) {
            Log.d("LOAD_LOCAL_RESULT", res.copy(users = emptyList()).toString())
            LoadResult.Page(
                data = res.users,
                prevKey = (page - 1).takeIf { it >= 0 },
                nextKey = (page + 1).takeIf { page != lastPage },
                itemsBefore = page * limit,
                itemsAfter = (totalCount - (page + 1) * limit).coerceAtLeast(0)
            )
        }
    }

    private fun invalidateOnChange(users: Flow<UserPaging>) {
        launch {
            users.drop(1)
                .collect { invalidate() }
        }
    }

    override fun getRefreshKey(state: PagingState<Int, UserData>): Int = 0
}

@OptIn(ExperimentalPagingApi::class)
class UserPagingMediator(
    private val getRemoteUsers: GetRemoteUsersUseCase,
    private val updateUserLocal: UpdateUserLocalUseCase
) : RemoteMediator<Int, UserData>() {

    override suspend fun load(
        loadType: LoadType,
        state: PagingState<Int, UserData>
    ): MediatorResult {
        val loadParams = when (loadType) {
            LoadType.REFRESH -> UserPagingParameters(
                0,
                state.config.initialLoadSize
            )
            LoadType.PREPEND -> return MediatorResult.Success(endOfPaginationReached = true)
            LoadType.APPEND -> {
                state.lastItemOrNull()?.let { lastKey ->
                    UserPagingParameters(
                        state.pages.size,
                        state.config.pageSize
                    )
                } ?: return MediatorResult.Success(endOfPaginationReached = true)
            }
        }
        Log.d("LOAD_REMOTE", loadParams.toString())

        return when (val res = getRemoteUsers(loadParams)) {
            is Result.Success -> {
                Log.d("LOAD_REMOTE_RESULT", res.data.copy(users = listOf()).toString())

                if (state.pages.lastOrNull()?.data?.containsAll(res.data.users) == false) {
                    updateUserLocal(res.data.users.map(UserData::asUserWithPlaceholders))
                }
                MediatorResult.Success(endOfPaginationReached = res.data.page == res.data.lastPage)
            }
            is Result.Error -> MediatorResult.Error(
                res.error.throwable ?: IllegalStateException(
                    "User list loading failed but no error found"
                )
            )
        }
    }

}