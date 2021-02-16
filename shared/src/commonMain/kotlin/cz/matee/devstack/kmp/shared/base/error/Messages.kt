package cz.matee.devstack.kmp.shared.base.error

import cz.matee.devstack.kmp.shared.base.ErrorResult

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