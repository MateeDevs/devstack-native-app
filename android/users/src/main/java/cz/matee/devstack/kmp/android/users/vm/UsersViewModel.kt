package cz.matee.devstack.kmp.android.users.vm

import androidx.lifecycle.viewModelScope
import androidx.paging.*
import cz.matee.devstack.kmp.android.shared.core.system.BaseStateViewModel
import cz.matee.devstack.kmp.android.shared.core.system.State
import cz.matee.devstack.kmp.android.users.data.UserPagingMediator
import cz.matee.devstack.kmp.android.users.data.UsersPagingSource
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.usecase.user.GetUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.map

private val pagingConfig = PagingConfig(15)

class UsersViewModel(
    getUsersSource: () -> UsersPagingSource,
    mediator: UserPagingMediator,
    private val getUserUseCase: GetUserUseCase
) : BaseStateViewModel<UsersViewModel.ViewState>(ViewState()) {

    @OptIn(ExperimentalPagingApi::class)
    private val pager = Pager(
        pagingConfig,
        null,
        remoteMediator = mediator,
        getUsersSource
    )
    val users: Flow<PagingData<UserPagingData>> get() = pager.flow.cachedIn(viewModelScope)

    private val _errorFlow = MutableSharedFlow<ErrorResult>(extraBufferCapacity = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    suspend fun getUser(id: String): Flow<User?> =
        getUserUseCase(GetUserUseCase.Params(id))
            .map { res ->
                when (res) {
                    is Result.Success -> res.data
                    is Result.Error -> {
                        _errorFlow.emit(res.error)
                        null
                    }
                }
            }

    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(

        val loading: Boolean = false
    ) : State
}