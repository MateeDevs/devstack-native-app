package kmp.shared.di

import io.ktor.client.engine.darwin.Darwin
import kmp.shared.base.error.ErrorMessageProvider
import kmp.shared.base.error.ErrorMessageProviderImpl
import kmp.shared.data.source.VideoSource
import kmp.shared.infrastructure.local.AVFoundationVideoCompressor
import kmp.shared.infrastructure.local.BaseIosVideoCompressor
import kmp.shared.infrastructure.local.BaseIosVideoCompressorParams
import kmp.shared.infrastructure.local.DriverFactory
import kmp.shared.infrastructure.local.VideoCompressor
import kmp.shared.infrastructure.source.VideoSourceImpl
import kmp.shared.system.Config
import kmp.shared.system.ConfigImpl
import kmp.shared.system.Log
import kmp.shared.system.Logger
import kotlinx.cinterop.ObjCClass
import kotlinx.cinterop.ObjCProtocol
import kotlinx.cinterop.getOriginalKotlinClass
import org.koin.core.Koin
import org.koin.core.parameter.parametersOf
import org.koin.core.qualifier.Qualifier
import org.koin.core.qualifier.named
import org.koin.dsl.module

fun initKoinIos(
    doOnStartup: () -> Unit,
    lightCompressorParamsCallback: (BaseIosVideoCompressorParams) -> Unit,
) =
    initKoin {
        modules(
            module {
                single { doOnStartup }
                single<VideoCompressor>(named("LightCompressor")) {
                    BaseIosVideoCompressor(
                        callback = lightCompressorParamsCallback,
                    )
                }
            },
        )
    }

actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single { DriverFactory() }
    single<Logger> { Log }
    single { Darwin.create() }
    single<ErrorMessageProvider> { ErrorMessageProviderImpl() }

    single<VideoCompressor>(named("AVFoundation")) { AVFoundationVideoCompressor() }
    single<VideoSource> {
        VideoSourceImpl(
            aVFoundationVideoCompressor = get(named("AVFoundation")),
            lightCompressorVideoCompressor = get(named("LightCompressor")),
        )
    }
}

fun Koin.get(objCProtocol: ObjCProtocol): Any {
    val kClazz = getOriginalKotlinClass(objCProtocol)!!
    return get(kClazz, null)
}

fun Koin.get(objCClass: ObjCClass): Any {
    val kClazz = getOriginalKotlinClass(objCClass)!!
    return get(kClazz, null)
}

fun Koin.get(objCClass: ObjCClass, qualifier: Qualifier?, parameter: Any): Any {
    val kClazz = getOriginalKotlinClass(objCClass)!!
    return get(kClazz, qualifier) { parametersOf(parameter) }
}

fun Koin.get(objCClass: ObjCClass, parameter: Any): Any {
    val kClazz = getOriginalKotlinClass(objCClass)!!
    return get(kClazz, null) { parametersOf(parameter) }
}

fun Koin.get(objCClass: ObjCClass, qualifier: Qualifier?): Any {
    val kClazz = getOriginalKotlinClass(objCClass)!!
    return get(kClazz, qualifier, null)
}
