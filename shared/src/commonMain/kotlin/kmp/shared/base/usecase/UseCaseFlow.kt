package kmp.shared.base.usecase

import kotlinx.coroutines.flow.Flow

interface UseCaseFlow<in Params, out T : Any> {
    suspend operator fun invoke(params: Params): Flow<T>
}

interface UseCaseFlowNoParams<out T : Any> {
    suspend operator fun invoke(): Flow<T>
}
