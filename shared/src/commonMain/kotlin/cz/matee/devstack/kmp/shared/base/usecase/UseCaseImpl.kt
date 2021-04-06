package cz.matee.devstack.kmp.shared.base.usecase

import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.withContext

interface UseCase<in Params, out T> {
    suspend operator fun invoke(params: Params): T
}

interface UseCaseNoParams<out T> : UseCase<Unit, T> {
    suspend operator fun invoke(): T
}

interface UseCaseFlow<in Params, out T : Any> : UseCase<Params, Flow<T>>
interface UseCaseFlowNoParams<out T : Any> : UseCase<Unit, Flow<T>> {
    suspend operator fun invoke(): Flow<T>
}

/**
 * Abstract class for a Use Case (Interactor in terms of Clean Architecture).
 * This interface represents an execution unit for different use cases (this means any use case
 * in the application should implement this contract).
 *
 * Use cases are the entry points to the domain layer.
 *
 */
abstract class UseCaseImpl<in Params, out T>(open val dispatcher: CoroutineDispatcher = Dispatchers.Default) {

    /**
     * Executes appropriate implementation of [UseCaseImpl],
     * @param params Set of input parameters
     * @return type [T] of parameter. In the most common way the [T] is wrapped to a special use-case implementation.
     */
    suspend operator fun invoke(params: Params): T = withContext(dispatcher) { doWork(params) }

    /**
     * Inner business logic of [UseCaseImpl]
     *
     * @param params Set of input parameters
     * @return type [T] of parameter. In the most common way the [T] is wrapped to a special use-case implementation.
     */
    abstract suspend fun doWork(params: Params): T
}


abstract class UseCaseNoParamsImpl<out T>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Unit, T>(dispatcher) {

    suspend operator fun invoke(): T = super.invoke(Unit)
}


abstract class UseCaseFlowImpl<in Params, out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Params, Flow<T>>(dispatcher)

abstract class UseCaseFlowNoParamsImpl<out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Unit, Flow<T>>(dispatcher) {
    suspend operator fun invoke(): Flow<T> = super.invoke(Unit)
}