package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.system.Config
import io.ktor.client.*
import io.ktor.client.features.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.*
import io.ktor.http.*
import io.ktor.util.pipeline.*

object HttpClient {
    private val unauthorizedEndpoints = listOf("/auth/login", "/auth/registration")

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
                    proceedWith(subject)
                }
                // (if token is null and destination needs authentication, throw [NoTokenException])
                else -> throw NoTokenException(url.build())
            }

        }
    }
}

class NoTokenException(url: Url) : Exception("No token provided for route ${url.fullPath}")

