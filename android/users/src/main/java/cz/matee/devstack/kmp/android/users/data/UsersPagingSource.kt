package cz.matee.devstack.kmp.android.users.data

import android.util.Log
import androidx.paging.*
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.usecase.user.*
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.first
import kotlin.coroutines.CoroutineContext

class UsersPagingSource(
    private val getLocalUsers: GetLocalUsersUseCase,
    private val userCacheChangeFlow: UserCacheChangeFlowUseCase
) : PagingSource<UserPagingParameters, UserPagingData>(), CoroutineScope {
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

        launch {
            userCacheChangeFlow().collect {
                invalidate()
            }
        }
    }

    override suspend fun load(
        params: LoadParams<UserPagingParameters>
    ): LoadResult<UserPagingParameters, UserPagingData> {
        val loadParams = params.key ?: UserPagingParameters(0, params.loadSize)

        val userFlow = getLocalUsers(loadParams)
        val res = userFlow.first()

        Log.d("LOAD_LOCAL", "O: ${loadParams.offset}; L: ${loadParams.limit}")

        // NEXT
//            val nextKey = loadParams.copy(offset = offset + params.loadSize).takeIf { it.offset <= totalCount }
        val nextKey = UserPagingParameters(res.offset + res.limit, params.loadSize)
            .takeIf { it.offset <= res.totalCount }

        // PREV
        val prevOffset = (res.offset - params.loadSize).coerceAtLeast(0)
        val prevLimit = if (res.offset < params.loadSize) res.offset else params.loadSize
        val prevKey = UserPagingParameters(prevOffset, prevLimit).takeIf { it.limit > 0 }

        return LoadResult.Page(res.users, prevKey, nextKey).also {
            Log.d("LOAD_KEYS", it.copy(data = emptyList()).toString())
        }
    }

    override fun getRefreshKey(
        state: PagingState<UserPagingParameters, UserPagingData>
    ): UserPagingParameters {
        var limit = state.anchorPosition ?: state.config.pageSize
        while (limit % state.config.pageSize != 0) limit += 1
        return UserPagingParameters(0, limit = limit)
    }
}

@OptIn(ExperimentalPagingApi::class)
class UserPagingMediator(
    private val getRemoteUsers: GetRemoteUsersUseCase,
    private val updateLocalCache: UpdateLocalUserCacheUseCase,
    private val replaceUserCacheWith: ReplaceUserCacheWithUseCase
) : RemoteMediator<UserPagingParameters, UserPagingData>() {
    private var loaded: IntRange? = null

    override suspend fun load(
        loadType: LoadType,
        state: PagingState<UserPagingParameters, UserPagingData>
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
                    limit = if (loadState.first < state.config.pageSize)
                        loadState.first
                    else state.config.pageSize
                )
            }
            LoadType.APPEND -> {
                val loadState = loaded
                    ?: error("Cannot append when not initialized (REFRESH load wasn't called)")

                UserPagingParameters(
                    offset = loadState.last + 1,
                    limit = state.config.pageSize
                )
            }
        }

        Log.d("LOAD_REMOTE", "$loadType - OFF: ${loadParams.offset}; LIM: ${loadParams.limit}")
        return when (val res = getRemoteUsers(loadParams)) {
            is Result.Success -> {
                val state = loaded
                val min = res.data.offset
                val max = res.data.offset + res.data.limit - 1
                if (state == null) loaded = min..max
                else {
                    if (min < state.first)
                        loaded = min..state.last
                    if (max > state.last)
                        loaded = state.first..max
                }

//                Log.d("LOAD_REMOTE_STATE", loaded.toString())

                if (loadType == LoadType.REFRESH)
                    replaceUserCacheWith(res.data.users)
                else
                    updateLocalCache(res.data.users)

                MediatorResult.Success(
                    (res.data.offset + res.data.limit) >= res.data.totalCount
                )
            }
            is Result.Error -> MediatorResult.Error(
                res.error.throwable ?: IllegalStateException(
                    "User list loading failed but no error found"
                )
            )
        }
    }

}
