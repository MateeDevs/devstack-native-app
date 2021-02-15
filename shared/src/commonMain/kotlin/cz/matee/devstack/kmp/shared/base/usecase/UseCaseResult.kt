package cz.matee.devstack.kmp.shared.base.usecase

import cz.matee.devstack.kmp.shared.base.Result
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Abstract class for a Use Case (Interactor in terms of Clean Architecture).
 * This interface represents an execution unit for different use cases (this means any use case
 * in the application should implement this contract).
 *
 * Use cases are the entry points to the domain layer.
 *
 */
abstract class UseCaseResult<in Params, out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCase<Params, Result<T>>(dispatcher)

abstract class UseCaseResultNoParams<out T : Any>(dispatcher: CoroutineDispatcher = Dispatchers.Default) :
    UseCase<Unit, Result<T>>(dispatcher) {
    suspend operator fun invoke() = super.invoke(Unit)
}