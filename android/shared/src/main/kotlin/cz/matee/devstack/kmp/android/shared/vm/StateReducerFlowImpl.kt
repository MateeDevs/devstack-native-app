package cz.matee.devstack.kmp.android.shared.vm

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.Channel
import kotlinx.coroutines.flow.FlowCollector
import kotlinx.coroutines.flow.SharingStarted.Companion.Eagerly
import kotlinx.coroutines.flow.receiveAsFlow
import kotlinx.coroutines.flow.runningFold
import kotlinx.coroutines.flow.stateIn

private class StateReducerFlowImpl<State, Intent>(
    initialState: State,
    reduceState: (State, Intent) -> State,
    scope: CoroutineScope
) : StateReducerFlow<State, Intent> {

    private val intents = Channel<Intent>()

    private val stateFlow = intents
        .receiveAsFlow()
        .runningFold(initialState, reduceState)
        .stateIn(scope, Eagerly, initialState)

    override val replayCache get() = stateFlow.replayCache

    override val value get() = stateFlow.value

    override suspend fun collect(collector: FlowCollector<State>): Nothing {
        stateFlow.collect(collector)
    }

    override fun handleIntent(intent: Intent) {
        intents.trySend(intent)
    }
}

fun <State, Event> ViewModel.stateReducerFlowOf(
    initialState: State,
    reduceState: (State, Event) -> State,
): StateReducerFlow<State, Event> =
    StateReducerFlowImpl(initialState, reduceState, viewModelScope)