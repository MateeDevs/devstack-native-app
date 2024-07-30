package kmp.shared.core.base.util.extension

import kmp.shared.core.base.Result

/** Transform Result data object */
inline fun <T : Any, R : Any> Result<T>.map(transform: (T) -> R) =
    when (this) {
        is Result.Success -> Result.Success(transform(data))
        is Result.Error -> Result.Error(error, data?.let(transform))
    }

fun <T : Any> Result<T>.toEmptyResult() = map { }

fun <T : Any> Result<T>.getOrNull(): T? =
    (this as? Result.Success)?.data
