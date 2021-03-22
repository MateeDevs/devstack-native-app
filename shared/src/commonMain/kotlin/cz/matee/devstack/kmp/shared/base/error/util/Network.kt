package cz.matee.devstack.kmp.shared.base.error.util

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.AuthError
import cz.matee.devstack.kmp.shared.base.error.domain.BackendError
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthPaths
import io.ktor.client.features.*
import io.ktor.client.statement.*
import io.ktor.http.*

internal inline fun <R : Any> runCatchingAuthNetworkExceptions(block: () -> Result<R>): Result<R> =
    runCatchingCommonNetworkExceptions {
        try {
            block()
        } catch (e: ClientRequestException) {
            when (e.response.status) {
                HttpStatusCode.Unauthorized ->
                    if (e.response.request.url.encodedPath == AuthPaths.login)
                        Result.Error(AuthError.InvalidLoginCredentials(e))
                    else throw e
                HttpStatusCode.Conflict ->
                    if (e.response.request.url.encodedPath == AuthPaths.registration)
                        Result.Error(AuthError.EmailAlreadyExist(e))
                    else throw e
                else -> throw e
            }
        }
    }

internal inline fun <R : Any> runCatchingCommonNetworkExceptions(block: () -> Result<R>): Result<R> =
    try {
        block()
    } catch (e: ClientRequestException) {
        when (e.response.status) {
            HttpStatusCode.Unauthorized -> Result.Error(
                BackendError.NotAuthorized(e.response.toString(), e)
            )
            else -> throw e
        }
    }
//    catch (e: ServerResponseException) {
//
//    }
    catch (e: Throwable) {
        when (e::class.simpleName) { // Handle platform specific exceptions
            "UnknownHostException" -> Result.Error(CommonError.NoNetworkConnection(e))

            else -> throw e // Rethrow exception when it's not matched
        }
    }