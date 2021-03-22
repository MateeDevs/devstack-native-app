package cz.matee.devstack.kmp.shared.di

import cz.matee.devstack.kmp.shared.infrastructure.local.DriverFactory
import cz.matee.devstack.kmp.shared.system.Config
import cz.matee.devstack.kmp.shared.system.ConfigImpl
import org.koin.dsl.module

actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single { DriverFactory(get()) }
}