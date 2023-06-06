package cz.matee.devstack.kmp.shared.base

import com.rickclephas.kmp.nativecoroutines.NativeCoroutinesState
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase.Params as LoginParams
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase.Params as RegisterParams

class TestViewModel(
    private val loginUseCase: LoginUseCase,
    private val registerUseCase: RegisterUseCase,
) : MyBaseViewModel<TestViewModel.ViewState, TestViewModel.ViewIntent>(ViewState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>(extraBufferCapacity = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    @NativeCoroutinesState
    val stateX: StateFlow<ViewState> = MutableStateFlow(ViewState())

    override suspend fun applyIntent(intent: ViewIntent) {
        when (intent) {
            ViewIntent.LogInTapped -> login(state.value.email, state.value.password)
            ViewIntent.RegisterTapped -> register(state.value.email, state.value.password)
            ViewIntent.OnViewAppeared -> incrementNumber()
        }
    }

    private suspend fun login(email: String, password: String): Boolean {
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

    private suspend fun register(
        email: String,
        password: String,
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

    private suspend fun incrementNumber() {
        while (true) {
            delay(2_000)
            update { copy(testNumber = testNumber + 1) }
            println("XXX ${state.value.testNumber}")
        }
    }

    private var loading
        get() = state.value.loading
        set(value) = update { copy(loading = value) }

    data class ViewState(
        val loading: Boolean = false,
        val email: String = "",
        val password: String = "",
        val testNumber: Int = 0,
    ) : VmState

    sealed interface ViewIntent : VmIntent {
        object LogInTapped : ViewIntent
        object RegisterTapped : ViewIntent
        object OnViewAppeared : ViewIntent
    }
}
