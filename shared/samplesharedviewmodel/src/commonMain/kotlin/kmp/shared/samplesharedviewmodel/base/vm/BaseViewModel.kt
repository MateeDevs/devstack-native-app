package org.skyseat.shared.base.viewmodel

import kmp.shared.samplesharedviewmodel.base.vm.BaseScopedViewModel
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.launch

abstract class BaseViewModel<S : VmState, I : VmIntent, E : VmEvent>(initialState: S) :
    BaseScopedViewModel<S, I, E>() {

    override val state: MutableStateFlow<S> = MutableStateFlow(initialState)

    protected val _events = MutableSharedFlow<E>()
    override val events = _events.asSharedFlow()

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
interface VmEvent
