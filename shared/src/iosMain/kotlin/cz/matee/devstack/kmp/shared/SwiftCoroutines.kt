package cz.matee.devstack.kmp.shared

import cz.matee.devstack.kmp.shared.base.*
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlow
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResult
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlowResultNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResult
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.onCompletion
import kotlinx.coroutines.flow.onEach
import kotlinx.coroutines.launch
import kotlin.coroutines.CoroutineContext

val iosDefaultScope: CoroutineScope = object : CoroutineScope {
    override val coroutineContext: CoroutineContext
        get() = SupervisorJob() + Dispatchers.Default
}

interface KMMViewModel {

    fun l(uc: RefreshBooksUseCase) {
        val a = execute(1, uc, onSuccess = {
        }, {
        },)
    }

    fun <Params : Any, Out : Any> execute(
        params: Params,
        uc: UseCaseResult<Params, Out>,
        onSuccess: (item: Result<Out>) -> Unit,
        onThrow: (error: Throwable) -> Unit,
    ) {
        uc.subscribe(params = params, onSuccess, onThrow)
    }
}

sealed class SuspendWrapperParent<Params, Out>(
    private val suspender: suspend (Params?) -> Out,
) {

    fun subscribe(
        params: Params? = null,
        onSuccess: (item: Out) -> Unit,
        onThrow: (error: Throwable) -> Unit,
    ): Job =
        iosDefaultScope.launch {
            try {
                onSuccess(suspender(params))
            } catch (error: Throwable) {
                onThrow(error)
            }
        }
}

class SuspendWrapper<Params : Any, Out : Any>(suspender: suspend (Params?) -> Out) :
    SuspendWrapperParent<Params, Out>(suspender)

fun <Params : Any, Out : Any> UseCaseResult<Params, Out>.subscribe(
    params: Params,
    onSuccess: (item: Result<Out>) -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    SuspendWrapper<Params, Result<Out>> { invoke(params) }.subscribe(params, onSuccess, onThrow)

fun <Params : Any, Out : Any> UseCaseResultNoParams<Out>.subscribe(
    onSuccess: (item: Result<Out>) -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    SuspendWrapper<Params, Result<Out>> { invoke() }.subscribe(
        onSuccess = onSuccess,
        onThrow = onThrow,
    )

sealed class FlowWrapperParent<Params, T>(private val suspender: suspend (Params?) -> Flow<T>) {

    fun subscribe(
        params: Params? = null,
        onEach: (item: T) -> Unit,
        onComplete: () -> Unit,
        onThrow: (error: Throwable) -> Unit,
    ): Job = iosDefaultScope.launch {
        suspender(params)
            .onEach {
                onEach(it)
            }
            .catch {
                onThrow(it)
            } // catch{} before onCompletion{} or else completion hits rx first and ends stream
            .onCompletion {
                onComplete()
            }
            .collect()
    }
}

class FlowWrapper<Params : Any, Out : Any>(flow: suspend (Params?) -> Flow<Out>) :
    FlowWrapperParent<Params, Out>(flow)

fun <Params : Any, Out : Any> UseCaseFlowResult<Params, Out>.subscribe(
    params: Params,
    onEach: (item: Result<Out>) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    FlowWrapper<Params, Result<Out>> { invoke(params) }.subscribe(
        params,
        onEach,
        onComplete,
        onThrow,
    )

fun <S : VmState> MyBaseViewModelInt<S, *>.subscribeToState(
    onEach: (item: S) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    iosDefaultScope.launch {
        state
            .onEach {
                onEach(it)
            }
            .catch {
                onThrow(it)
            } // catch{} before onCompletion{} or else completion hits rx first and ends stream
            .onCompletion {
                onComplete()
            }
            .collect()
    }

fun <S : VmState> StateFlow<S>.myCoolSubscribe(
    onEach: (item: S) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    iosDefaultScope.launch {
        this@myCoolSubscribe
            .onEach {
                onEach(it)
            }
            .catch {
                onThrow(it)
            } // catch{} before onCompletion{} or else completion hits rx first and ends stream
            .onCompletion {
                onComplete()
            }
            .collect()
    }

fun <Params : Any, Out : Any> UseCaseFlowResultNoParams<Out>.subscribe(
    onEach: (item: Result<Out>) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    FlowWrapper<Params, Result<Out>> { invoke() }.subscribe(
        onEach = onEach,
        onComplete = onComplete,
        onThrow = onThrow,
    )

fun <Params : Any, Out : Any> UseCaseFlow<Params, Out>.subscribe(
    params: Params,
    onEach: (item: Out) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    FlowWrapper<Params, Out> { invoke(params) }.subscribe(
        params,
        onEach,
        onComplete,
        onThrow,
    )

fun <Params : Any, Out : Any> UseCaseFlowNoParams<Out>.subscribe(
    onEach: (item: Out) -> Unit,
    onComplete: () -> Unit,
    onThrow: (error: Throwable) -> Unit,
): Job =
    FlowWrapper<Params, Out> { invoke() }.subscribe(
        onEach = onEach,
        onComplete = onComplete,
        onThrow = onThrow,
    )
