package cz.matee.devstack.kmp.android.profile.vm

import cz.matee.and.core.system.BaseStateViewModel
import cz.matee.and.core.system.State
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.usecase.GetLoggedInUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

class ProfileViewModel(
    private val getLoggedInUser: GetLoggedInUserUseCase
) : BaseStateViewModel<ProfileViewModel.ViewState>(ViewState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>(extraBufferCapacity = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow


    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(
        val user: User? = null,
        val loading: Boolean = false
    ) : State
}