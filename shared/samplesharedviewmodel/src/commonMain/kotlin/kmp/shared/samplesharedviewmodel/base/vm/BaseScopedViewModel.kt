package kmp.shared.samplesharedviewmodel.base.vm

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.flow.SharedFlow
import kotlinx.coroutines.flow.StateFlow
import org.skyseat.shared.base.viewmodel.VmEvent
import org.skyseat.shared.base.viewmodel.VmIntent
import org.skyseat.shared.base.viewmodel.VmState

expect abstract class BaseScopedViewModel<S : VmState, I : VmIntent, E : VmEvent>() :
    BaseViewModelInt<S, I, E> {

    override val viewModelScope: CoroutineScope
    protected open fun onCleared()
}

interface BaseViewModelInt<S : VmState, I : VmIntent, E : VmEvent> {

    val viewModelScope: CoroutineScope

    val state: StateFlow<S>
    val events: SharedFlow<E>

    fun onIntent(intent: I)
}
