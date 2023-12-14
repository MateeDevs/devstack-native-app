package kmp.shared.base.error

import kmp.shared.base.ErrorResult

interface ErrorMessageProvider {
    val defaultMessage: String

    /**
     * Returns error message for given [ErrorResult]. If no corresponding message is found, a [defMessage] is returned instead
     * @receiver [ErrorResult] which is used to determine the message
     * @param defMessage Used if no message is found for given [ErrorResult]
     * @return [String] Error message for given [ErrorResult]
     */
    fun ErrorResult.getMessage(defMessage: String = defaultMessage): String
}

fun ErrorMessageProvider.getMessage(error: ErrorResult, defMessage: String? = null) =
    if (defMessage != null) {
        error.getMessage(defMessage)
    } else {
        error.getMessage()
    }
