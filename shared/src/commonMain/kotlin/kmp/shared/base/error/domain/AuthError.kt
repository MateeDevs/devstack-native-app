package kmp.shared.base.error.domain

import kmp.shared.base.ErrorResult

sealed class AuthError(
    message: String? = null,
    throwable: Throwable? = null,
) : ErrorResult(message, throwable) {

    class InvalidLoginCredentials(throwable: Throwable?) : AuthError(null, throwable)
    class EmailAlreadyExist(throwable: Throwable?) : AuthError(null, throwable)
}
