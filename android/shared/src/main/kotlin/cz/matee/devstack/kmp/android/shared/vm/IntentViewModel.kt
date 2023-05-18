package cz.matee.devstack.kmp.android.shared.vm

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.collectAsState
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

abstract class IntentViewModel<State : VmState, Model : VmModel, Intent : VmIntent, Event : ReducerEvent>(
    initialState: State,
    initialModel: Model,
) : ViewModel() {

    private val modelFlow = stateReducerFlowOf(
        initialState = ReducedState(reducedState = initialState, event = null),
        initialModel = initialModel,
        reduceState = ::reduceState,
        reduceModel = ::reduceModel,
    )

    @Composable
    fun collectModel() = modelFlow.collectAsState()

    fun onIntent(intent: Intent) = modelFlow.handleIntent(intent)

    private fun reduceState(state: ReducedState<State, Event?>, intent: Intent): ReducedState<State, Event?> =
        state.reducedState.applyIntent(intent)

    private fun reduceModel(state: State, message: Event): Model = state.applyEvent(event = message)

    protected abstract fun State.applyIntent(intent: Intent): ReducedState<State, Event>

    protected abstract fun State.applyEvent(event: Event): Model
}

/**
 * Base state of every view that is held in view model.
 */
interface VmState

/**
 * Base intent interface
 */
interface VmIntent

/**
 * Base message used by reducer to map state changes to model
 */
interface ReducerEvent

@Immutable
interface VmModel

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Model : VmModel, Intent : VmIntent, Event : ReducerEvent> IntentViewModel<State, Model, Intent, Event>.intentFlow(
    producer: UseCaseFlowNoParams<T>,
    intent: (T) -> Intent
) = intentFlow(
    producer = { producer() },
    intent = intent,
)

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Model : VmModel, Intent : VmIntent, Event : ReducerEvent> IntentViewModel<State, Model, Intent, Event>.intentFlow(
    producer: suspend () -> Flow<T>,
    intent: (T) -> Intent
) {
    viewModelScope.launch { producer().collect { onIntent(intent(it)) } }
}