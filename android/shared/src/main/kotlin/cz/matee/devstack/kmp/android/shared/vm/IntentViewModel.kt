package cz.matee.devstack.kmp.android.shared.vm

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.collectAsState
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

abstract class IntentViewModel<State : VmState, Model : VmModel, Intent : VmIntent, Message : ReducerMessage>(
    initialState: State,
    initialModel: Model,
) : ViewModel() {

    private val modelFlow = stateReducerFlowOf(
        initialState = ReducedState(reducedState = initialState, message = null),
        initialModel = initialModel,
        reduceState = ::reduceState,
        reduceModel = ::reduceModel,
    )

    @Composable
    fun collectModel() = modelFlow.collectAsState()

    fun onIntent(intent: Intent) = modelFlow.handleIntent(intent)

    private fun reduceState(state: ReducedState<State, Message?>, intent: Intent): ReducedState<State, Message?> =
        state.reducedState.applyIntent(intent)

    private fun reduceModel(state: State, message: Message?): Model = state.applyMessage(message = message)

    protected abstract fun State.applyIntent(intent: Intent?): ReducedState<State, Message>

    protected abstract fun State.applyMessage(message: Message?): Model
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
interface ReducerMessage

@Immutable
interface VmModel

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Model : VmModel, Intent : VmIntent, Message : ReducerMessage> IntentViewModel<State, Model, Intent, Message>.intentFlow(
    producer: UseCaseFlowNoParams<T>,
    intent: (T) -> Intent
) = intentFlow(
    producer = { producer() },
    intent = intent,
)

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Model : VmModel, Intent : VmIntent, Message : ReducerMessage> IntentViewModel<State, Model, Intent, Message>.intentFlow(
    producer: suspend () -> Flow<T>,
    intent: (T) -> Intent
) {
    viewModelScope.launch { producer().collect { onIntent(intent(it)) } }
}