package cz.matee.devstack.kmp.shared.base.util.helpers

import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import io.ktor.client.call.*
import io.ktor.client.statement.*

sealed interface ResultType
object Success : ResultType
class Error(val error: ErrorResult) : ResultType

suspend inline infix fun <reified T : Any> HttpResponse.resultsTo(result: ResultType): Result<T> =
    when (result) {
        Success -> Result.Success(body<T>())
        is Error -> Result.Error(result.error, null)
    }

infix fun <T : Any> T.resultsTo(result: ResultType): Result<T> =
    when (result) {
        Success -> Result.Success(this)
        is Error -> Result.Error(result.error, null)
    }

infix fun <T : Any> T?.resultsTo(result: ErrorResult): Result<T> =
    this?.resultsTo(Error(result)) ?: Result.Error(result, null)