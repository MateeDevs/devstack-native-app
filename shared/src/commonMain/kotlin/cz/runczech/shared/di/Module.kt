package cz.runczech.shared.di

import com.russhwolf.settings.Settings
import org.koin.core.KoinApplication
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.module

fun initKoin(appDeclaration: KoinAppDeclaration = {}): KoinApplication {
    val koinApplication = startKoin {
        appDeclaration()
        modules(commonModule,
         //   platformModule
        )
    }

    // Dummy initialization logic, making use of appModule declarations for demonstration purposes.
    val koin = koinApplication.koin
    val doOnStartup =
        koin.getOrNull<() -> Unit>() // doOnStartup is a lambda which is implemented in Swift on iOS side
    doOnStartup?.invoke()

    return koinApplication
}

private val commonModule = module {

    // General
//    single { HttpClient.init(get(), get()) }
    single { Settings() }

    // UseCases



    // Repositories


    // Sources
//    single<AuthSource> { AuthSourceImpl(get(), get()) }
//    single<UserRemoteSource> { UserRemoteSourceImpl(get()) }
//    single<UserLocalSource> { UserLocalSourceImpl(get(), get()) }
//    single<BookLocalSource> { BookLocalSourceImpl(get()) }

    // DAOs
//    single<AuthDao> { AuthDaoImpl(get()) }

    // Http Services

    // Database
//    single { createDatabase(get()) }
//    single { get<Database>().userQueries }
//    single { get<Database>().userCacheQueries }
//    single { get<Database>().bookQueries }
}
//
//expect val platformModule: Module