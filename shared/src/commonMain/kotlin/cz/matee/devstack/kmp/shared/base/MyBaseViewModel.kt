package cz.matee.devstack.kmp.shared.base

import com.rickclephas.kmp.nativecoroutines.NativeCoroutinesState
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch

abstract class MyBaseViewModel<S : VmState, I : VmIntent>(initialState: S) : ViewModel() {

    @NativeCoroutinesState
    val state: MutableStateFlow<S> = MutableStateFlow(initialState)

    fun onIntent(intent: I) {
        viewModelScope.launch {
            applyIntent(intent)
        }
    }

    protected fun update(body: S.() -> S) {
        state.value = body(state.value)
    }

    protected abstract suspend fun applyIntent(intent: I)
}

interface VmState
interface VmIntent
