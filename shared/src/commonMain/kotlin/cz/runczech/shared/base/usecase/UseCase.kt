package cz.runczech.shared.base.usecase

import kotlinx.coroutines.flow.Flow

@Deprecated("Do not use - user only uc with result")
interface UseCase<in Params, out T> {
    suspend operator fun invoke(params: Params): T
}

@Deprecated("Do not use - user only uc with result")
interface UseCaseNoParams<out T> {
    suspend operator fun invoke(): T
}

interface UseCaseFlow<in Params, out T : Any> {
    suspend operator fun invoke(params: Params): Flow<T>
}

interface UseCaseFlowNoParams<out T : Any> {
    suspend operator fun invoke(): Flow<T>
}