package cz.matee.devstack.kmp.shared.base

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch

interface MyBaseViewModelInt<S : VmState, I : VmIntent> {

    val state: MutableStateFlow<S>

    fun onIntent(intent: I)
}

abstract class MyBaseViewModel<S : VmState, I : VmIntent>(initialState: S) :
    ViewModel(),
    MyBaseViewModelInt<S, I> {

    override val state: MutableStateFlow<S> = MutableStateFlow(initialState)

    override fun onIntent(intent: I) {
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
