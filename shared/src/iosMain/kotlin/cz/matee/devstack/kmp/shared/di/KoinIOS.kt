package cz.matee.devstack.kmp.shared.di

import cz.matee.devstack.kmp.shared.infrastructure.local.DriverFactory
import cz.matee.devstack.kmp.shared.system.Config
import cz.matee.devstack.kmp.shared.system.ConfigImpl
import kotlinx.cinterop.ObjCClass
import kotlinx.cinterop.getOriginalKotlinClass
import org.koin.core.Koin
import org.koin.core.parameter.parametersOf
import org.koin.core.qualifier.Qualifier
import org.koin.dsl.module

fun initKoinIos(doOnStartup: () -> Unit) = initKoin {
    modules(
        module {
            single { doOnStartup }
        }
    )
}


actual val platformModule = module {
    single<Config> { ConfigImpl() }
    single { DriverFactory() }
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