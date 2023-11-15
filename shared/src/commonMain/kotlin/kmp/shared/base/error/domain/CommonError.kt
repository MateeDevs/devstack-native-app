package kmp.shared.base.error.domain

import kmp.shared.base.ErrorResult

/**
 * Error type used anywhere in the project. Contains subclasses for common exceptions that can happen anywhere
 * @param throwable optional [Throwable] parameter used for debugging or crash reporting
 */
sealed class CommonError(throwable: Throwable? = null) : ErrorResult(throwable = throwable) {
    class NoNetworkConnection(t: Throwable?) : CommonError(t)
    object NoUserLoggedIn : CommonError()
}
