package cz.matee.devstack.kmp.shared.di

import io.ktor.client.*
import io.ktor.client.features.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.module

fun initKoin(appDeclaration: KoinAppDeclaration = {}) = startKoin {
    appDeclaration()
    modules(commonModule)
}

private val commonModule = module {
    httpClient()
}

private fun Module.httpClient() {
    HttpClient {
        install(JsonFeature) {
            serializer = KotlinxSerializer()
        }

        defaultRequest {

        }
    }
}
