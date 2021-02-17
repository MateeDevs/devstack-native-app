package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.infrastructure.model.LoginDto
import cz.matee.devstack.kmp.shared.system.Config
import io.ktor.client.HttpClient
import io.ktor.client.call.*
import io.ktor.client.features.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*
import io.ktor.util.pipeline.*

object HttpClient {
    private val unauthorizedEndpoints = listOf("/auth/login", "/auth/registration")
    private val clients = mutableListOf<HttpClient>()

    fun init(authDao: AuthDao, config: Config) = HttpClient {

        developmentMode = !config.isRelease
        followRedirects = false

        install(JsonFeature) {
            serializer = KotlinxSerializer()
        }

        defaultRequest {
            url {
                protocol = URLProtocol.HTTPS
                host = "matee-devstack.herokuapp.com/api"
            }
            contentType(ContentType.Application.Json)
        }

        HttpResponseValidator {
            handleResponseException {

            }
        }

        install("auth_interceptor") {
            requestPipeline.intercept(HttpRequestPipeline.Phases.Before) {
                interceptTokenAuth(authDao)
            }
            responsePipeline.intercept(HttpResponsePipeline.Phases.After) {
                interceptTokenResponse(authDao)
            }
        }
    }.also(clients::add)

    fun close() {
        clients.forEach(HttpClient::close)
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
        authDao: AuthDao
    ) {
        with(context) {
            val isSuccessfulLoginResponse =
                request.url.encodedPath == AuthPaths.login
                        && response.status == HttpStatusCode.OK

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

class NoTokenException(url: Url) : Exception("No token provided for route ${url.fullPath}")

