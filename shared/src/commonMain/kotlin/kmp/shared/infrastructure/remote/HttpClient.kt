package kmp.shared.infrastructure.remote

import io.ktor.client.HttpClient
import io.ktor.client.call.HttpClientCall
import io.ktor.client.engine.HttpClientEngine
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.defaultRequest
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.Logger
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.request.HttpRequestBuilder
import io.ktor.client.request.HttpRequestPipeline
import io.ktor.client.request.headers
import io.ktor.client.statement.HttpResponseContainer
import io.ktor.client.statement.HttpResponsePipeline
import io.ktor.http.ContentType
import io.ktor.http.HttpHeaders
import io.ktor.http.HttpStatusCode
import io.ktor.http.URLProtocol
import io.ktor.http.Url
import io.ktor.http.contentType
import io.ktor.http.encodedPath
import io.ktor.http.fullPath
import io.ktor.serialization.kotlinx.json.json
import io.ktor.util.pipeline.PipelineContext
import kmp.shared.infrastructure.local.AuthDao
import kmp.shared.infrastructure.model.LoginDto
import kmp.shared.system.Config
import kotlin.native.concurrent.ThreadLocal
import co.touchlab.kermit.Logger as KermitLogger
import kotlinx.serialization.json.Json as JsonConfig

internal object HttpClient {
    private val unauthorizedEndpoints = listOf("/api/auth/login", "/api/auth/registration")

    fun init(authDao: AuthDao, config: Config, engine: HttpClientEngine) = HttpClient(engine) {
        expectSuccess = true
        developmentMode = !config.isRelease
        followRedirects = false

        install(ContentNegotiation) {
            json(globalJson)
        }

        if (!config.isRelease) {
            install(Logging) {
                logger = object : Logger {
                    override fun log(message: String) {
                        KermitLogger.d { message }
                    }
                }
                level = LogLevel.ALL
            }
        }

        defaultRequest {
            url {
                protocol = URLProtocol.HTTPS
                host = "devstack-server-production.up.railway.app"
            }
            contentType(ContentType.Application.Json)
        }

        install("auth_interceptor") {
            requestPipeline.intercept(HttpRequestPipeline.Phases.Before) {
                interceptTokenAuth(authDao)
            }
            responsePipeline.intercept(HttpResponsePipeline.Phases.After) {
                interceptTokenResponse(authDao)
            }
        }
    }

    private suspend fun PipelineContext<Any, HttpRequestBuilder>.interceptTokenAuth(authDao: AuthDao) {
        val token = authDao.retrieveToken()

        with(context) {
            // Proceed without changes if destination does not need authentication
            when {
                unauthorizedEndpoints.any(url.encodedPath::equals) -> proceedWith(subject)
                // Append token if
                token != null -> {
                    headers {
                        append(HttpHeaders.Authorization, "Bearer $token")
                    }
                }
                // (if token is null and destination needs authentication, throw [NoTokenException])
                else -> throw NoTokenException(url.build())
            }
        }
    }

    private fun PipelineContext<HttpResponseContainer, HttpClientCall>.interceptTokenResponse(
        authDao: AuthDao,
    ) {
        with(context) {
            val isSuccessfulLoginResponse =
                request.url.encodedPath == AuthPaths.login &&
                    response.status == HttpStatusCode.OK

            if (isSuccessfulLoginResponse) {
                val res = subject.response as? LoginDto
                if (res != null) {
                    authDao.saveToken(res.token)
                    authDao.saveUserId(res.userId)
                }
            }
        }
    }
}

@ThreadLocal
val globalJson = JsonConfig {
    ignoreUnknownKeys = true
    coerceInputValues = true
    useAlternativeNames = false
}

class NoTokenException(url: Url) : Exception("No token provided for route ${url.fullPath}")
