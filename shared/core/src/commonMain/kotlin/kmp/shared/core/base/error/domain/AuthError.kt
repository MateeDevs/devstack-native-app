package kmp.shared.core.base.error.domain

import kmp.shared.core.base.ErrorResult

sealed class AuthError(
    message: String? = null,
    throwable: Throwable? = null,
) : ErrorResult(message, throwable) {

    class InvalidLoginCredentials(throwable: Throwable?) : AuthError(null, throwable)
    class EmailAlreadyExist(throwable: Throwable?) : AuthError(null, throwable)
    class LoginFailed(throwable: Throwable?) : AuthError(null, throwable)
    class RegistrationFailed(throwable: Throwable?) : AuthError(null, throwable)
}
