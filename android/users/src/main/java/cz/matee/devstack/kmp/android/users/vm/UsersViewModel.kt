package cz.matee.devstack.kmp.android.users.vm

import androidx.paging.Pager
import androidx.paging.PagingConfig
import androidx.paging.PagingData
import cz.matee.and.core.system.BaseStateViewModel
import cz.matee.and.core.system.State
import cz.matee.devstack.kmp.android.users.data.UsersPagingSource
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.model.UserData
import cz.matee.devstack.kmp.shared.domain.usecase.GetUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

private val pagingConfig = PagingConfig(10)

class UsersViewModel(
    getUsersSource: () -> UsersPagingSource,
    private val getUserUseCase: GetUserUseCase
) : BaseStateViewModel<UsersViewModel.ViewState>(ViewState()) {

    private val pager = Pager(pagingConfig, 0, getUsersSource)
    val users: Flow<PagingData<UserData>> get() = pager.flow

    private val _errorFlow = MutableSharedFlow<ErrorResult>(extraBufferCapacity = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    suspend fun getUser(id: String): User? =
        when (val res = getUserUseCase(GetUserUseCase.Params(id))) {
            is Result.Success -> res.data
            is Result.Error -> {
                _errorFlow.emit(res.error)
                null
            }
        }

    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(

        val loading: Boolean = false
    ) : State
}