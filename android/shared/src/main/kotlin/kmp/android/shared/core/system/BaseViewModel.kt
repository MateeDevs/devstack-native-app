package kmp.android.shared.core.system

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.CoroutineStart
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

public abstract class BaseViewModel(
    private val defaultDispatcher: CoroutineDispatcher = Dispatchers.IO,
) : ViewModel() {

    /**
     * Collect flow in [viewModelScope]
     * @param flow Flow that will be collected
     * @param collector function which will be called on each emit.
     * @return reference to the coroutine as a [Job]
     */
    protected fun <T> collect(
        flow: Flow<T>,
        context: CoroutineContext = Dispatchers.Default,
        collector: suspend (T) -> Unit,
    ): Job = launch(context) {
        flow.collect(collector)
    }

    @Deprecated("Use launch instead", ReplaceWith("launch(block)"))
    protected fun launchOnIO(
        block: suspend CoroutineScope.() -> Unit,
    ): Job = launch(defaultDispatcher) { block() }

    /**
     * Launch coroutine in [viewModelScope] with [context]
     * @param context additional to [CoroutineScope.coroutineContext] context of the coroutine.
     * @param start coroutine start option. The default value is [CoroutineStart.DEFAULT].
     * @param block the coroutine code which will be invoked in the context of the provided scope.
     * @return reference to the coroutine as a [Job]
     */
    protected fun launch(
        context: CoroutineContext = defaultDispatcher,
        start: CoroutineStart = CoroutineStart.DEFAULT,
        block: suspend CoroutineScope.() -> Unit,
    ): Job = viewModelScope.launch(context, start, block)
}

/**
 * Holds state of UI component bound to [BaseStateViewModel]
 */
public interface State

public abstract class BaseStateViewModel<S : State>(
    initialState: S,
    defaultDispatcher: CoroutineDispatcher = Dispatchers.IO,
) : BaseViewModel(defaultDispatcher) {

    private val stateFlow = MutableStateFlow(initialState)
    public val state: Flow<S> = stateFlow

    protected fun update(body: S.() -> S) {
        stateFlow.value = body(stateFlow.value)
    }

    public fun lastState(): S = stateFlow.value
}
