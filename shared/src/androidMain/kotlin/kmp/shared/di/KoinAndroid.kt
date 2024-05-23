package kmp.shared.di

import io.ktor.client.engine.android.Android
import kmp.shared.base.error.ErrorMessageProvider
import kmp.shared.base.error.ErrorMessageProviderImpl
import kmp.shared.data.source.VideoSource
import kmp.shared.infrastructure.local.DriverFactory
import kmp.shared.infrastructure.local.LiTrVideoCompressor
import kmp.shared.infrastructure.local.LightCompressorVideoCompressor
import kmp.shared.infrastructure.local.TranscoderVideoCompressor
import kmp.shared.infrastructure.local.VideoCompressor
import kmp.shared.infrastructure.source.VideoSourceImpl
import kmp.shared.system.Config
import kmp.shared.system.ConfigImpl
import kmp.shared.system.Log
import kmp.shared.system.Logger
import org.koin.core.qualifier.named
import org.koin.dsl.module

actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single { DriverFactory(get()) }
    single<Logger> { Log }
    single { Android.create() }
    single<ErrorMessageProvider> { ErrorMessageProviderImpl(get()) }

    single<VideoCompressor>(named("Transcoder")) { TranscoderVideoCompressor(get()) }
    single<VideoCompressor>(named("LiTr")) { LiTrVideoCompressor(get()) }
    single<VideoCompressor>(named("LightCompressor")) { LightCompressorVideoCompressor(get()) }

    single<VideoSource> {
        VideoSourceImpl(
            transcoderVideoCompressor = get(named("Transcoder")),
            liTrVideoCompressor = get(named("LiTr")),
            lightCompressorVideoCompressor = get(named("LightCompressor")),
        )
    }
}
