package cz.matee.devstack.kmp.android.shared.vm

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.collectAsState
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch

abstract class IntentViewModel<State : VmState, Intent : VmIntent>(
    initialState: State,
) : ViewModel() {
    private val stateFlow = stateReducerFlowOf(
        initialState = initialState,
        reduceState = ::reduceState,
    )

    @Composable
    fun collectState() = stateFlow.collectAsState()

    fun onIntent(intent: Intent) = stateFlow.handleIntent(intent)

    private fun reduceState(state: State, intent: Intent): State =
        state.applyIntent(intent)

    protected abstract fun State.applyIntent(intent: Intent): State
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
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Intent : VmIntent> IntentViewModel<State, Intent>.intentFlow(
    producer: UseCaseFlowNoParams<T>,
    intent: (T) -> Intent
) {
    viewModelScope.launch { producer().collect { onIntent(intent(it)) } }
}

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Intent : VmIntent> IntentViewModel<State, Intent>.intentFlow(
    producer: suspend () -> Flow<T>,
    intent: (T) -> Intent
) {
    viewModelScope.launch { producer().collect { onIntent(intent(it)) } }
}