package kmp.android.shared.vm

import androidx.compose.runtime.Immutable
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.coroutines.launch

abstract class BaseIntentViewModel<S : VmState, I : VmIntent, E : VmEvent>(initialState: S) :
    ViewModel() {

    val state: MutableStateFlow<S> = MutableStateFlow(initialState)

    protected val _events = MutableSharedFlow<E>()
    val events = _events.asSharedFlow()

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

/**
 * Base state of every view that is held in view model.
 */
@Immutable
interface VmState

/**
 * Base intent interface
 */
interface VmIntent

/**
 * Base event interface
 */
interface VmEvent
