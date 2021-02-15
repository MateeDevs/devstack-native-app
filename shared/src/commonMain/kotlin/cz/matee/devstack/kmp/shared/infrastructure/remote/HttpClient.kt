package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import io.ktor.client.*
import io.ktor.client.features.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.request.*
import io.ktor.util.pipeline.*

object HttpClient {
    private val unauthorizedEndpoints = listOf("/auth/login", "/auth/registration")

    fun init(authDao: AuthDao) = HttpClient {
        developmentMode = true

        install(JsonFeature) {
            serializer = KotlinxSerializer()
        }

        defaultRequest {
            host = "https://matee-devstack.herokuapp.com/api"
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

            // Proceed without changes if token does not exist or destination does not need authentication
            // (if token is null and destination needs authentication, [NotAuthorized] error will be returned by exception handler
            if (token == null || unauthorizedEndpoints.any(url.encodedPath::endsWith))
                proceed()
            else {

            }
        }
    }
}

