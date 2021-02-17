package cz.matee.devstack.kmp.android.users.vm

import cz.matee.and.core.system.BaseStateViewModel
import cz.matee.and.core.system.State
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.domain.repository.UserPagingParameters
import cz.matee.devstack.kmp.shared.domain.usecase.GetPagedUsersUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.GetUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class UsersViewModel(
    private val getPagedUsersUseCase: GetPagedUsersUseCase,
    private val getUserUseCase: GetUserUseCase
) : BaseStateViewModel<UsersViewModel.ViewState>(ViewState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>(extraBufferCapacity = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    suspend fun getUsers() = getPagedUsersUseCase(UserPagingParameters(1, 100))

    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(

        val loading: Boolean = false
    ) : State
}