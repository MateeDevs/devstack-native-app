package cz.matee.devstack.kmp.android.shared.vm

import kotlinx.coroutines.flow.StateFlow

interface StateReducerFlow<Model, Intent, Message> : StateFlow<Model> {
    fun handleIntent(intent: Intent)
}