package kmp.shared.base.error.domain

import kmp.shared.base.ErrorResult

/**
 * Error type used when handling responses from backend
 * @param throwable optional [Throwable] parameter used for debugging or crash reporting
 */
sealed class BackendError(
    throwable: Throwable? = null,
    responseMessage: String? = null,
) : ErrorResult(throwable = throwable, message = responseMessage) {

    class NotAuthorized(
        responseMessage: String?,
        throwable: Throwable? = null,
    ) : BackendError(throwable, responseMessage)
}
