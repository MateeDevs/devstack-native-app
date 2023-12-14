package kmp.shared.base.error.util

import io.ktor.client.plugins.ClientRequestException
import io.ktor.client.statement.request
import io.ktor.http.HttpStatusCode
import kmp.shared.base.Result
import kmp.shared.base.error.domain.AuthError
import kmp.shared.base.error.domain.BackendError
import kmp.shared.base.error.domain.CommonError
import kmp.shared.infrastructure.remote.AuthPaths

internal inline fun <R : Any> runCatchingAuthNetworkExceptions(block: () -> R): Result<R> =
    try {
        Result.Success(block())
    } catch (e: ClientRequestException) {
        when (e.response.status) {
            HttpStatusCode.Unauthorized ->
                if (e.response.request.url.encodedPath == AuthPaths.login) {
                    Result.Error(AuthError.InvalidLoginCredentials(e))
                } else {
                    throw e
                }

            HttpStatusCode.Conflict ->
                if (e.response.request.url.encodedPath == AuthPaths.registration) {
                    Result.Error(AuthError.EmailAlreadyExist(e))
                } else {
                    throw e
                }

            else -> throw e
        }
    } catch (e: Throwable) {
        when (e::class.simpleName) { // Handle platform specific exceptions
            "UnknownHostException" -> Result.Error(CommonError.NoNetworkConnection(e))
            else -> throw e // Rethrow exception when it's not matched
        }
    }

internal inline fun <R : Any> runCatchingCommonNetworkExceptions(block: () -> R): Result<R> =
    try {
        Result.Success(block())
    } catch (e: ClientRequestException) {
        when (e.response.status) {
            HttpStatusCode.Unauthorized -> Result.Error(
                BackendError.NotAuthorized(e.response.toString(), e),
            )

            else -> throw e
        }
    } catch (e: Throwable) {
        when (e::class.simpleName) { // Handle platform specific exceptions
            "UnknownHostException" -> Result.Error(CommonError.NoNetworkConnection(e))
            else -> throw e // Rethrow exception when it's not matched
        }
    }
