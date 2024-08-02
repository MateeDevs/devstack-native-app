package kmp.shared.samplesharedviewmodel.base.vm

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancelChildren
import org.skyseat.shared.base.viewmodel.VmEvent
import org.skyseat.shared.base.viewmodel.VmIntent
import org.skyseat.shared.base.viewmodel.VmState

/**
 * Base class that provides a Kotlin/Native equivalent to the AndroidX `ViewModel`. In particular, this provides
 * a [CoroutineScope][kotlinx.coroutines.CoroutineScope] which uses [Dispatchers.Main][kotlinx.coroutines.Dispatchers.Main]
 * and can be tied into an arbitrary lifecycle by calling [clear] at the appropriate time.
 */
actual abstract class BaseScopedViewModel<S : VmState, I : VmIntent, E : VmEvent> :
    BaseViewModelInt<S, I, E> {

    private var _viewModelScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)
    actual override val viewModelScope
        get() = _viewModelScope

    /**
     * Override this to do any cleanup immediately before the internal [CoroutineScope][kotlinx.coroutines.CoroutineScope]
     * is cancelled in [clear]
     */
    protected actual open fun onCleared() {
    }

    /**
     * Cancels the children of the Context of the internal [CoroutineScope][kotlinx.coroutines.CoroutineScope].
     * Can be called for example from .onDispose of a SwiftUI View, but beware, the behaviour would differ from AndroidX view model
     * where the lifecycle is not stopped until the screen is no longer in the backstack
     * (meaning it lives if the user navigates to next screen, but not when he navigates back)
     */
    fun clear() {
        onCleared()
        viewModelScope.coroutineContext.cancelChildren()
    }
}
