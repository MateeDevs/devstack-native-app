package kmp.shared.base.di

import io.ktor.client.engine.darwin.Darwin
import kmp.shared.base.error.ErrorMessageProvider
import kmp.shared.base.error.ErrorMessageProviderImpl
import kmp.shared.base.system.Config
import kmp.shared.base.system.ConfigImpl
import kmp.shared.base.system.Log
import kmp.shared.base.system.Logger
import org.koin.dsl.module

actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single<Logger> { Log }
    single { Darwin.create() }
    single<ErrorMessageProvider> { ErrorMessageProviderImpl() }
}
