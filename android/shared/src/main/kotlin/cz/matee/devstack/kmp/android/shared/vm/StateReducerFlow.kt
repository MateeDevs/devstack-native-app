package cz.matee.devstack.kmp.android.shared.vm

import kotlinx.coroutines.flow.StateFlow

interface StateReducerFlow<State, Intent> : StateFlow<State> {
    fun handleIntent(intent: Intent)
}