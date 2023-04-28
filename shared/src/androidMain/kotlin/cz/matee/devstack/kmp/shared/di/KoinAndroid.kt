package cz.matee.devstack.kmp.shared.di

import cz.matee.devstack.kmp.shared.data.source.VideoSource
import cz.matee.devstack.kmp.shared.infrastructure.local.DriverFactory
import cz.matee.devstack.kmp.shared.infrastructure.local.TranscoderVideoCompressor
import cz.matee.devstack.kmp.shared.infrastructure.local.VideoCompressor
import cz.matee.devstack.kmp.shared.infrastructure.source.VideoSourceImpl
import cz.matee.devstack.kmp.shared.system.Config
import cz.matee.devstack.kmp.shared.system.ConfigImpl
import cz.matee.devstack.kmp.shared.system.Log
import cz.matee.devstack.kmp.shared.system.Logger
import org.koin.core.module.dsl.factoryOf
import org.koin.dsl.bind
import org.koin.dsl.module

actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single { DriverFactory(get()) }
    single<Logger> { Log }

    factoryOf(::TranscoderVideoCompressor) bind VideoCompressor::class

    factoryOf(::VideoSourceImpl) bind VideoSource::class
}
