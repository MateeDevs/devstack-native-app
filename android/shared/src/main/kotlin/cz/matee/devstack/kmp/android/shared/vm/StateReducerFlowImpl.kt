package cz.matee.devstack.kmp.android.shared.vm

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.flow.SharingStarted.Companion.Eagerly

private class StateReducerFlowImpl<State, Model, Intent, Message>(
    initialState: ReducedState<State, Message?>,
    initialModel: Model,
    reduceState: (ReducedState<State, Message?>, Intent) -> ReducedState<State, Message?>,
    reduceModel: (State, Message?) -> Model,
    scope: CoroutineScope
) : StateReducerFlow<Model, Intent, Message> {

    private val intents = Channel<Intent>()

    private val stateFlow = intents
        .receiveAsFlow()
        .runningFold(initialState, reduceState)
        .map { state -> reduceModel(state.reducedState, state.message) }
        .stateIn(scope, Eagerly, initialModel)

    override val replayCache get() = stateFlow.replayCache

    override val value get() = stateFlow.value

    override suspend fun collect(collector: FlowCollector<Model>): Nothing {
        stateFlow.collect(collector)
    }

    override fun handleIntent(intent: Intent) {
        intents.trySend(intent)
    }
}

fun <State, Model, Intent, Message> ViewModel.stateReducerFlowOf(
    initialState: ReducedState<State, Message?>,
    initialModel: Model,
    reduceState: (ReducedState<State, Message?>, Intent) -> ReducedState<State, Message?>,
    reduceModel: (State, Message?) -> Model,
): StateReducerFlow<Model, Intent, Message> =
    StateReducerFlowImpl(
        initialState = initialState,
        initialModel = initialModel,
        reduceState = reduceState,
        reduceModel = reduceModel,
        scope = viewModelScope,
    )