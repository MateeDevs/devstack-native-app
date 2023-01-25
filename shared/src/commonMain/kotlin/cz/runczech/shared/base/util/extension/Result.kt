package cz.runczech.shared.base.util.extension

import cz.runczech.shared.base.Result

/** Transform Result data object */
inline fun <T : Any, R : Any> Result<T>.map(transform: (T) -> R) =
    when (this) {
        is Result.Success -> Result.Success(transform(data))
        is Result.Error -> Result.Error(error, data?.let(transform))
    }

inline fun <T : Any> Result<T>.toEmptyResult() = map { }