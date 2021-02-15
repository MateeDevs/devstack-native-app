package cz.matee.devstack.kmp.android.login.vm

import cz.matee.and.core.system.BaseStateViewModel
import cz.matee.and.core.system.State
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthService

class LoginViewModel(
    private val authService: AuthService
) : BaseStateViewModel<LoginViewModel.ViewState>(ViewState()) {

    suspend fun login(request: AuthService.LoginRequest) {
        val response = authService.login(request)
        print(response)
    }

    data class ViewState(
        val loading: Boolean = false
    ) : State
}