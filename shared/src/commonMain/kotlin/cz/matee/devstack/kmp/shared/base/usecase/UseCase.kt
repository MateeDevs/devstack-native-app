package cz.matee.devstack.kmp.shared.base.usecase

import cz.matee.devstack.kmp.shared.base.Result
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.withContext

/**
 * Abstract class for a Use Case (Interactor in terms of Clean Architecture).
 * This interface represents an execution unit for different use cases (this means any use case
 * in the application should implement this contract).
 *
 * Use cases are the entry points to the domain layer.
 *
 */
abstract class UseCase<in Params, out T>(open val dispatcher: CoroutineDispatcher = Dispatchers.Default) {

    /**
     * Executes appropriate implementation of [UseCase],
     * @param params Set of input parameters
     * @return type [T] of parameter. In the most common way the [T] is wrapped to a special use-case implementation.
     */
    suspend operator fun invoke(params: Params): T = withContext(dispatcher) { doWork(params) }

    /**
     * Inner business logic of [UseCase]
     *
     * @param params Set of input parameters
     * @return type [T] of parameter. In the most common way the [T] is wrapped to a special use-case implementation.
     */
    protected abstract suspend fun doWork(params: Params): T
}


abstract class UseCaseNoParams<out T>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCase<Unit, T>(dispatcher) {

    suspend operator fun invoke(): T = super.invoke(Unit)
}


abstract class UseCaseFlow<in Params, out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCase<Params, Flow<T>>(dispatcher)

abstract class UseCaseFlowNoParams<out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCase<Unit, Flow<T>>(dispatcher) {
    suspend operator fun invoke(): Flow<T> = super.invoke(Unit)
}