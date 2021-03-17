package cz.matee.devstack.kmp.android.login.vm

import cz.matee.and.core.system.BaseStateViewModel
import cz.matee.and.core.system.State
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase.Params as LoginParams
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase.Params as RegisterParams

class AuthViewModel(
    private val loginUseCase: LoginUseCase,
    private val registerUseCase: RegisterUseCase,
) : BaseStateViewModel<AuthViewModel.ViewState>(ViewState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>(extraBufferCapacity = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    suspend fun login(email: String, password: String): Boolean {
        loading = true

        val loginResult = when (
            val res = loginUseCase(LoginParams(email, password))
        ) {
            is Result.Success -> true
            is Result.Error -> {
                _errorFlow.emit(res.error)
                false
            }
        }

        loading = false
        return loginResult
    }

    suspend fun register(
        email: String,
        password: String
    ): Boolean {
        loading = true

        val registerResult = when (
            val res = registerUseCase(RegisterParams(email, "", "", password))
        ) {
            is Result.Success -> true
            is Result.Error -> {
                _errorFlow.emit(res.error)
                false
            }
        }

        loading = false
        return registerResult
    }

    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(
        val loading: Boolean = false
    ) : State
}