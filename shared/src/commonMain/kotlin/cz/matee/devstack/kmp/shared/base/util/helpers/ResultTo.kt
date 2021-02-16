package cz.matee.devstack.kmp.shared.base.util.helpers

import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result

// TODO refactor to sealed interface
sealed class ResultType
object Success : ResultType()
class Error(val error: ErrorResult) : ResultType()

infix fun <T : Any> T.resultsTo(result: ResultType): Result<T> =
    when (result) {
        Success -> Result.Success(this)
        is Error -> Result.Error(result.error, null)
    }

infix fun <T : Any> T?.resultsTo(result: ErrorResult): Result<T> =
    this?.resultsTo(Error(result)) ?: Result.Error(result, null)