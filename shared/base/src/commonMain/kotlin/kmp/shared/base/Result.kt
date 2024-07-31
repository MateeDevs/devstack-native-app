package kmp.shared.base

sealed class Result<out T : Any> {

    data class Success<out T : Any>(val data: T) : Result<T>()

    data class Error<out T : Any>(val error: ErrorResult, val data: T? = null) : Result<T>()
}

open class ErrorResult(open var message: String? = null, open var throwable: Throwable? = null)
