package cz.matee.devstack.kmp.android.shared.vm

import androidx.compose.runtime.Composable
import androidx.compose.runtime.Immutable
import androidx.compose.runtime.collectAsState
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch

abstract class IntentViewModel<State : VmState, Model : VmModel, Intent : VmIntent>(
    initialState: State,
    initialModel: Model,
) : ViewModel() {

    private val modelFlow = stateReducerFlowOf(
        initialState = initialState,
        initialModel = initialModel,
        reduceState = ::reduceState,
        mapToModel = ::mapToModel,
    )

    @Composable
    fun collectModel() = modelFlow.collectAsState()

    fun onIntent(intent: Intent) = modelFlow.handleIntent(intent)

    private fun reduceState(state: State, intent: Intent): State = state.applyIntent(intent)

    protected abstract fun State.applyIntent(intent: Intent): State

    protected abstract fun mapToModel(state: State): Model
}

/**
 * Base state of every view that is held in view model.
 */
interface VmState

/**
 * Base intent interface
 */
interface VmIntent

@Immutable
interface VmModel

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Model: VmModel, Intent : VmIntent> IntentViewModel<State, Model, Intent>.intentFlow(
    producer: UseCaseFlowNoParams<T>,
    intent: (T) -> Intent
) = intentFlow(
    producer = { producer() },
    intent = intent,
)

/**
 * Calls [IntentViewModel.onIntent] with the specified [intent] on every emission of [producer]
 */
fun <T : Any, State : VmState, Model: VmModel, Intent : VmIntent> IntentViewModel<State, Model, Intent>.intentFlow(
    producer: suspend () -> Flow<T>,
    intent: (T) -> Intent
) {
    viewModelScope.launch { producer().collect { onIntent(intent(it)) } }
}