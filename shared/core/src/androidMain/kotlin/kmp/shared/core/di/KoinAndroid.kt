package kmp.shared.core.di

import io.ktor.client.engine.android.Android
import kmp.shared.core.base.error.ErrorMessageProvider
import kmp.shared.core.base.error.ErrorMessageProviderImpl
import kmp.shared.core.infrastructure.local.DriverFactory
import kmp.shared.core.system.Config
import kmp.shared.core.system.ConfigImpl
import kmp.shared.core.system.Log
import kmp.shared.core.system.Logger
import org.koin.dsl.module

actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single { DriverFactory(get()) }
    single<Logger> { Log }
    single { Android.create() }
    single<ErrorMessageProvider> { ErrorMessageProviderImpl(get()) }
}
