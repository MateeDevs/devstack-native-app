package cz.matee.devstack.kmp.android.shared.vm

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.flow.SharingStarted.Companion.Eagerly

private class StateReducerFlowImpl<State, Model, Intent>(
    initialState: State,
    initialModel: Model,
    reduceState: (State, Intent) -> State,
    mapToModel: (State) -> Model,
    scope: CoroutineScope
) : StateReducerFlow<Model, Intent> {

    private val intents = Channel<Intent>()

    private val stateFlow = intents
        .receiveAsFlow()
        .runningFold(initialState, reduceState)
        .map { mapToModel(it) }
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

fun <State, Model, Event> ViewModel.stateReducerFlowOf(
    initialState: State,
    initialModel: Model,
    reduceState: (State, Event) -> State,
    mapToModel: (State) -> Model,
): StateReducerFlow<Model, Event> =
    StateReducerFlowImpl(
        initialState = initialState,
        initialModel = initialModel,
        reduceState = reduceState,
        mapToModel = mapToModel,
        scope = viewModelScope,
    )