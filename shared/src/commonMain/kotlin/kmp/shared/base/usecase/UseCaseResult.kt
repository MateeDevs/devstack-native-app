package kmp.shared.base.usecase

import kmp.shared.base.Result
import kotlinx.coroutines.flow.Flow

/**
 * Interface for a Use Case (Interactor in terms of Clean Architecture).
 * This interface represents an execution unit for different use cases (this means any use case
 * in the application should implement this contract).
 *
 * Use cases are the entry points to the domain layer.
 *
 */

interface UseCaseResult<in Params, out T : Any> {
    suspend operator fun invoke(params: Params): Result<T>
}

interface UseCaseResultNoParams<out T : Any> {
    suspend operator fun invoke(): Result<T>
}

interface UseCaseFlowResult<in Params, out T : Any> {
    suspend operator fun invoke(params: Params): Flow<Result<T>>
}

interface UseCaseFlowResultNoParams<out T : Any> {
    suspend operator fun invoke(): Flow<Result<T>>
}
