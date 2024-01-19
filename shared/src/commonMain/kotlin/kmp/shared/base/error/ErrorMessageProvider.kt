package kmp.shared.base.error

import dev.icerock.moko.resources.desc.StringDesc
import dev.icerock.moko.resources.desc.desc
import kmp.shared.MR
import kmp.shared.base.ErrorResult
import kmp.shared.base.error.domain.AuthError
import kmp.shared.base.error.domain.BackendError
import kmp.shared.base.error.domain.CommonError

abstract class ErrorMessageProvider {
    private val defaultMessage: StringDesc
        get() = MR.strings.unknown_error.desc()

    abstract fun StringDesc.toMessageString(): String

    /**
     * Returns error message for given [ErrorResult]. If no corresponding message is found, a [defMessage] is returned instead
     * @receiver [ErrorResult] which is used to determine the message
     * @param defMessage Used if no message is found for given [ErrorResult]
     * @return [String] Error message for given [ErrorResult]
     */
    internal fun ErrorResult.getMessage(): String {
        return when (this) {
            is AuthError -> errorMessage
            is BackendError -> errorMessage
            is CommonError -> errorMessage
            else -> defaultMessage
        }.toMessageString()
    }

    internal fun ErrorResult.getMessage(defMessage: String): String {
        return when (this) {
            is AuthError -> errorMessage
            is BackendError -> errorMessage
            is CommonError -> errorMessage
            else -> null
        }?.toMessageString() ?: defMessage
    }

    private val AuthError.errorMessage: StringDesc
        get() = when (this) {
            is AuthError.InvalidLoginCredentials -> MR.strings.login_view_error_invalid_credentials.desc()
            is AuthError.EmailAlreadyExist -> MR.strings.register_view_email_already_exists.desc()
            is AuthError.LoginFailed -> MR.strings.login_failed.desc()
            is AuthError.RegistrationFailed -> MR.strings.registration_failed.desc()
        }

    private val BackendError.errorMessage: StringDesc
        get() = when (this) {
            is BackendError.NotAuthorized -> MR.strings.not_authorized.desc()
        }

    private val CommonError.errorMessage: StringDesc
        get() =
            when (this) {
                is CommonError.NoNetworkConnection -> MR.strings.error_no_internet_connection.desc()
                CommonError.NoUserLoggedIn -> MR.strings.no_user_logged_in.desc()
            }
}

fun ErrorMessageProvider.getMessage(error: ErrorResult, defMessage: String? = null) =
    if (defMessage != null) {
        error.getMessage(defMessage)
    } else {
        error.getMessage()
    }
