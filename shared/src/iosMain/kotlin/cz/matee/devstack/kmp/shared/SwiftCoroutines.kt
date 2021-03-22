package cz.matee.devstack.kmp.shared

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.*
import kotlinx.coroutines.*
import kotlinx.coroutines.flow.*
import kotlin.coroutines.CoroutineContext
import kotlin.native.concurrent.freeze


val iosDefaultScope: CoroutineScope = object : CoroutineScope {
    override val coroutineContext: CoroutineContext
        get() = SupervisorJob() + Dispatchers.Default
}

sealed class SuspendWrapperParent<Params, Out>(
    private val suspender: suspend (Params?) -> Out
) {

    init {
        freeze()
    }

    fun subscribe(
        params: Params? = null,
        onSuccess: (item: Out) -> Unit,
        onThrow: (error: Throwable) -> Unit
    ): Job =
        iosDefaultScope.launch {
            try {
                onSuccess(suspender(params).freeze())
            } catch (error: Throwable) {
                onThrow(error.freeze())
            }
        }.freeze()

}

class SuspendWrapper<Params : Any, Out : Any>(suspender: suspend (Params?) -> Out) :
    SuspendWrapperParent<Params, Out>(suspender)


fun <Params : Any, Out : Any> UseCase<Params, Out>.subscribe(
    params: Params,
    onSuccess: (item: Out) -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    SuspendWrapper<Params, Out> { invoke(params) }.subscribe(params, onSuccess, onThrow)


fun <Params : Any, Out : Any> UseCaseNoParams<Out>.subscribe(
    onSuccess: (item: Out) -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    SuspendWrapper<Params, Out> { invoke() }.subscribe(onSuccess = onSuccess, onThrow = onThrow)

fun <Params : Any, Out : Any> UseCaseResult<Params, Out>.subscribe(
    params: Params,
    onSuccess: (item: Result<Out>) -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    SuspendWrapper<Params, Result<Out>> { invoke(params) }.subscribe(params, onSuccess, onThrow)

fun <Params : Any, Out : Any> UseCaseResultNoParams<Out>.subscribe(
    onSuccess: (item: Result<Out>) -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    SuspendWrapper<Params, Result<Out>> { invoke() }.subscribe(
        onSuccess = onSuccess,
        onThrow = onThrow
    )


sealed class FlowWrapperParent<Params, T>(private val suspender: suspend (Params?) -> Flow<T>) {
    init {
        freeze()
    }

    fun subscribe(
        params: Params? = null,
        onEach: (item: T) -> Unit,
        onComplete: () -> Unit,
        onThrow: (error: Throwable) -> Unit
    ): Job = iosDefaultScope.launch {
        suspender(params)
            .onEach {
                onEach(it.freeze())
            }
            .catch {
                onThrow(it.freeze())
            } // catch{} before onCompletion{} or else completion hits rx first and ends stream
            .onCompletion {
                onComplete()
            }
            .collect()
    }.freeze()
}

class FlowWrapper<Params : Any, Out : Any>(flow: suspend (Params?) -> Flow<Out>) :
    FlowWrapperParent<Params, Out>(flow)

fun <Params : Any, Out : Any> UseCaseFlowResult<Params, Out>.subscribe(
    params: Params,
    onEach: (item: Result<Out>) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    FlowWrapper<Params, Result<Out>> { invoke(params) }.subscribe(
        params, onEach, onComplete, onThrow
    )

fun <Params : Any, Out : Any> UseCaseFlowResultNoParams<Out>.subscribe(
    onEach: (item: Result<Out>) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    FlowWrapper<Params, Result<Out>> { invoke() }.subscribe(
        onEach = onEach, onComplete = onComplete, onThrow = onThrow
    )


fun <Params : Any, Out : Any> UseCaseFlow<Params, Out>.subscribe(
    params: Params,
    onEach: (item: Out) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    FlowWrapper<Params, Out> { invoke(params) }.subscribe(
        params, onEach, onComplete, onThrow
    )

fun <Params : Any, Out : Any> UseCaseFlowNoParams<Out>.subscribe(
    onEach: (item: Out) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit
): Job =
    FlowWrapper<Params, Out> { invoke() }.subscribe(
        onEach = onEach, onComplete = onComplete, onThrow = onThrow
    )