package kmp.android.users.data

import androidx.paging.ExperimentalPagingApi
import androidx.paging.LoadType
import androidx.paging.PagingSource
import androidx.paging.PagingState
import androidx.paging.RemoteMediator
import kmp.shared.base.Result
import kmp.shared.base.util.extension.getOrNull
import kmp.shared.domain.model.UserPagingData
import kmp.shared.domain.repository.UserPagingParameters
import kmp.shared.domain.usecase.user.GetLocalUsersUseCase
import kmp.shared.domain.usecase.user.GetRemoteUsersUseCase
import kmp.shared.domain.usecase.user.ReplaceUserCacheWithUseCase
import kmp.shared.domain.usecase.user.UpdateLocalUserCacheUseCase
import kmp.shared.domain.usecase.user.UserCacheChangeFlowUseCase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.job
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

class UsersPagingSource(
    private val getLocalUsers: GetLocalUsersUseCase,
    private val userCacheChangeFlow: UserCacheChangeFlowUseCase,
) : PagingSource<UserPagingParameters, UserPagingData>(), CoroutineScope {
    override val coroutineContext: CoroutineContext = Job() + Dispatchers.IO

    private val invalidatedCallback: () -> Unit = {
        coroutineContext.cancel()
    }

    init {
        registerInvalidatedCallback(invalidatedCallback)
        coroutineContext.job.invokeOnCompletion {
            unregisterInvalidatedCallback(invalidatedCallback)
            invalidate()
        }

        launch {
            userCacheChangeFlow().getOrNull()?.collect {
                invalidate()
            }
        }
    }

    override suspend fun load(
        params: LoadParams<UserPagingParameters>,
    ): LoadResult<UserPagingParameters, UserPagingData> {
        val loadParams = params.key ?: UserPagingParameters(0, params.loadSize)

        val userFlow = getLocalUsers(loadParams)
        val res = userFlow.first()

        // NEXT
        val nextKey = UserPagingParameters(res.offset + res.limit, params.loadSize)
            .takeIf { it.offset <= res.totalCount }

        // PREV
        val prevOffset = (res.offset - params.loadSize).coerceAtLeast(0)
        val prevLimit = if (res.offset < params.loadSize) res.offset else params.loadSize
        val prevKey = UserPagingParameters(prevOffset, prevLimit)
            .takeIf { it.limit > 0 }

        return LoadResult.Page(res.users, prevKey, nextKey)
    }

    override fun getRefreshKey(
        state: PagingState<UserPagingParameters, UserPagingData>,
    ): UserPagingParameters {
        var limit = state.anchorPosition ?: state.config.pageSize
        while (limit % state.config.pageSize != 0) limit += 1 // Expand limit to be a full page
        // pages are calculated (limit/pageSize) and converted to Int so any uncompleted pages get cut off

        return UserPagingParameters(0, limit = limit)
    }
}

@OptIn(ExperimentalPagingApi::class)
class UserPagingMediator(
    private val getRemoteUsers: GetRemoteUsersUseCase,
    private val updateLocalCache: UpdateLocalUserCacheUseCase,
    private val replaceUserCacheWith: ReplaceUserCacheWithUseCase,
) : RemoteMediator<UserPagingParameters, UserPagingData>() {
    private var loaded: IntRange? = null

    override suspend fun load(
        loadType: LoadType,
        state: PagingState<UserPagingParameters, UserPagingData>,
    ): MediatorResult {
        val loadParams = when (loadType) {
            LoadType.REFRESH -> {
                loaded = null
                UserPagingParameters(0, state.config.initialLoadSize + state.config.pageSize)
            }

            LoadType.PREPEND -> {
                val loadState = loaded
                    ?: error("Cannot prepend when not initialized (REFRESH load wasn't called)")
                if (loadState.first == 0) return MediatorResult.Success(true)

                val offset = (loadState.first - state.config.pageSize).coerceAtLeast(0)
                UserPagingParameters(
                    offset = offset,
                    limit = if (loadState.first < state.config.pageSize) {
                        loadState.first
                    } else {
                        state.config.pageSize
                    },
                )
            }

            LoadType.APPEND -> {
                val loadState = loaded
                    ?: error("Cannot append when not initialized (REFRESH load wasn't called)")

                UserPagingParameters(
                    offset = loadState.last + 1,
                    limit = state.config.pageSize,
                )
            }
        }

        return when (val res = getRemoteUsers(loadParams)) {
            is Result.Success -> {
                val loadedRange = loaded
                val min = res.data.offset
                val max = res.data.offset + res.data.limit - 1
                if (loadedRange == null) {
                    loaded = min..max // set range from result on refresh
                } else {
                    if (min < loadedRange.first) {
                        loaded = min..loadedRange.last
                    }
                    if (max > loadedRange.last) {
                        loaded = loadedRange.first..max
                    }
                }

                if (loadType == LoadType.REFRESH) {
                    replaceUserCacheWith(res.data.users)
                } else {
                    updateLocalCache(res.data.users)
                }

                MediatorResult.Success(
                    (res.data.offset + res.data.limit) >= res.data.totalCount,
                )
            }

            is Result.Error -> MediatorResult.Error(
                res.error.throwable ?: IllegalStateException(
                    "User list loading failed but no error found",
                ),
            )
        }
    }
}
