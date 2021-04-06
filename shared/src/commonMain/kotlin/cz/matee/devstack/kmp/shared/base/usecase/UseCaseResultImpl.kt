package cz.matee.devstack.kmp.shared.base.usecase

import cz.matee.devstack.kmp.shared.base.Result
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow

/**
 * Abstract class for a Use Case (Interactor in terms of Clean Architecture).
 * This interface represents an execution unit for different use cases (this means any use case
 * in the application should implement this contract).
 *
 * Use cases are the entry points to the domain layer.
 *
 */


interface UseCaseResult<in Params, out T : Any> : UseCase<Params, Result<T>>
interface UseCaseResultNoParams<out T : Any> {
    suspend operator fun invoke(): Result<T>
}

interface UseCaseFlowResult<in Params, out T : Any> : UseCase<Params, Flow<Result<T>>>
interface UseCaseFlowResultNoParams<out T : Any> : UseCase<Unit, Flow<Result<T>>> {
    suspend operator fun invoke(): Flow<Result<T>>
}


abstract class UseCaseResultImpl<in Params, out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Params, Result<T>>(dispatcher)

abstract class UseCaseResultNoParamsImpl<out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Unit, Result<T>>(dispatcher) {
    suspend operator fun invoke() = super.invoke(Unit)
}

abstract class UseCaseFlowResultImpl<in Params, out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Params, Flow<Result<T>>>(dispatcher)

abstract class UseCaseFlowResultNoParamsImpl<out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCaseImpl<Unit, Flow<Result<T>>>(dispatcher) {
    suspend operator fun invoke(): Flow<Result<T>> = super.invoke(Unit)
}