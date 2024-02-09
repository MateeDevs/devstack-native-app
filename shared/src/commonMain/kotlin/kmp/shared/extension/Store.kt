package kmp.shared.extension

import kmp.shared.base.ErrorResult
import kmp.shared.base.ErrorResultException
import kmp.shared.base.Result
import kmp.shared.base.error.domain.CommonError
import kmp.shared.infrastructure.model.UserDto
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.filterNot
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.map
import org.mobilenativefoundation.store.store5.MutableStore
import org.mobilenativefoundation.store.store5.StoreReadRequest
import org.mobilenativefoundation.store.store5.StoreReadResponse
import org.mobilenativefoundation.store.store5.StoreWriteResponse

fun <Key : Any, Output : Any> MutableStore<Key, Output>.getResultFlow(key: Key): Flow<Result<Output>> =
    stream<UserDto>(StoreReadRequest.cached(key, refresh = true))
        .filterNot { it is StoreReadResponse.Loading || it is StoreReadResponse.NoNewData }
        .map(StoreReadResponse<Output>::toResult)

suspend fun <Key : Any, Output : Any> MutableStore<Key, Output>.getResult(key: Key): Result<Output> =
    getResultFlow(key).first()

inline fun <T : Any> StoreReadResponse<T>.toResult(): Result<T> = when (this) {
    is StoreReadResponse.Data -> Result.Success(value)

    is StoreReadResponse.Error.Exception -> Result.Error(CommonError.UnhandledExceptionError(error))
    is StoreReadResponse.Error.Message -> Result.Error(
        CommonError.UnhandledExceptionError(RuntimeException(message)),
    )

    is StoreReadResponse.Error.Custom<*> -> {
        val errorResult: ErrorResult = error as? ErrorResult ?: error("Unknown custom error $error")
        Result.Error(errorResult)
    }

    else -> error("Illegal store state $this. Should be filtered out")
}

inline fun <reified T : Any> StoreWriteResponse.toResult(): Result<T> = when (this) {
    is StoreWriteResponse.Success -> {
        if (T::class == Unit::class) {
            // ignore the actual type when consumer asks for Unit
            Result.Success(Unit as T)
        } else {
            val resValue = when (this) {
                is StoreWriteResponse.Success.Typed<*> -> value
                is StoreWriteResponse.Success.Untyped -> value
            }

            if (resValue is T) {
                Result.Success(resValue)
            } else {
                throw ClassCastException("Could not cast ${resValue::class} to type ${T::class}")
            }
        }
    }

    is StoreWriteResponse.Error.Exception -> {
        val errorResult = (error as? ErrorResultException)?.error
            ?: CommonError.UnhandledExceptionError(error)

        Result.Error(errorResult)
    }

    is StoreWriteResponse.Error.Message -> Result.Error(
        CommonError.UnhandledExceptionError(RuntimeException(message)),
    )
}
