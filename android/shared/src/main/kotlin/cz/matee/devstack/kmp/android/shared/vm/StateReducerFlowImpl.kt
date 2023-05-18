package cz.matee.devstack.kmp.android.shared.vm

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.flow.SharingStarted.Companion.Eagerly

private class StateReducerFlowImpl<State, Model, Intent, Event>(
    initialState: ReducedState<State, Event?>,
    initialModel: Model,
    reduceState: (ReducedState<State, Event?>, Intent) -> ReducedState<State, Event?>,
    reduceModel: (State, Event) -> Model,
    scope: CoroutineScope
) : StateReducerFlow<Model, Intent, Event> {

    private val intents = Channel<Intent>()

    private val stateFlow = intents
        .receiveAsFlow()
        .runningFold(initialState, reduceState)
        .mapNotNull { state ->
            if (state.event != null) reduceModel(state.reducedState, state.event) else null
        }
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

fun <State, Model, Intent, Event> ViewModel.stateReducerFlowOf(
    initialState: ReducedState<State, Event?>,
    initialModel: Model,
    reduceState: (ReducedState<State, Event?>, Intent) -> ReducedState<State, Event?>,
    reduceModel: (State, Event) -> Model,
): StateReducerFlow<Model, Intent, Event> =
    StateReducerFlowImpl(
        initialState = initialState,
        initialModel = initialModel,
        reduceState = reduceState,
        reduceModel = reduceModel,
        scope = viewModelScope,
    )