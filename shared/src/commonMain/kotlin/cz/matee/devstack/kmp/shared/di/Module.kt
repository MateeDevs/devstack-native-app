package cz.matee.devstack.kmp.shared.di

import com.russhwolf.settings.Settings
import cz.matee.devstack.kmp.Database
import cz.matee.devstack.kmp.shared.data.repository.AuthRepositoryImpl
import cz.matee.devstack.kmp.shared.data.repository.BookRepositoryImpl
import cz.matee.devstack.kmp.shared.data.repository.UserRepositoryImpl
import cz.matee.devstack.kmp.shared.data.source.AuthSource
import cz.matee.devstack.kmp.shared.data.source.BookLocalSource
import cz.matee.devstack.kmp.shared.data.source.UserLocalSource
import cz.matee.devstack.kmp.shared.data.source.UserRemoteSource
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import cz.matee.devstack.kmp.shared.domain.usecase.DeleteAuthDataUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.user.GetUsersUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.GetBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.user.*
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDaoImpl
import cz.matee.devstack.kmp.shared.infrastructure.local.createDatabase
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthService
import cz.matee.devstack.kmp.shared.infrastructure.remote.HttpClient
import cz.matee.devstack.kmp.shared.infrastructure.remote.UserService
import cz.matee.devstack.kmp.shared.infrastructure.source.AuthSourceImpl
import cz.matee.devstack.kmp.shared.infrastructure.source.BookLocalSourceImpl
import cz.matee.devstack.kmp.shared.infrastructure.source.UserLocalSourceImpl
import cz.matee.devstack.kmp.shared.infrastructure.source.UserRemoteSourceImpl
import org.koin.core.KoinApplication
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.module

fun initKoin(appDeclaration: KoinAppDeclaration = {}): KoinApplication {
    val koinApplication = startKoin {
        appDeclaration()
        modules(commonModule, platformModule)
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
    single { HttpClient.init(get(), get()) }
    single { Settings() }

    // UseCases
    factory { LoginUseCase(get()) }
    factory { DeleteAuthDataUseCase(get()) }
    factory { RegisterUseCase(get()) }
    factory { GetLoggedInUserUseCase(get()) }
    factory { GetRemoteUsersUseCase(get()) }
    factory { GetLocalUsersUseCase(get()) }
    factory { GetUsersUseCase(get()) }
    factory { RefreshUsersUseCase(get()) }
    factory { GetUserUseCase(get()) }
    factory { IsUserLoggedInUseCase(get()) }
    factory { UpdateUserUseCase(get()) }
    factory { UpdateLocalUserCacheUseCase(get()) }
    factory { UserCacheChangeFlowUseCase(get()) }
    factory { ReplaceUserCacheWithUseCase(get()) }
    factory { GetBooksUseCase(get()) }
    factory { RefreshBooksUseCase(get()) }


    // Repositories
    single<AuthRepository> { AuthRepositoryImpl(get()) }
    single<BookRepository> { BookRepositoryImpl(get()) }
    single<UserRepository> { UserRepositoryImpl(get(), get(), get()) }

    // Sources
    single<AuthSource> { AuthSourceImpl(get(), get()) }
    single<UserRemoteSource> { UserRemoteSourceImpl(get()) }
    single<UserLocalSource> { UserLocalSourceImpl(get(), get()) }
    single<BookLocalSource> { BookLocalSourceImpl(get()) }

    // DAOs
    single<AuthDao> { AuthDaoImpl(get()) }

    // Http Services
    single { AuthService(get()) }
    single { UserService(get()) }

    // Database
    single { createDatabase(get()) }
    single { get<Database>().userQueries }
    single { get<Database>().userCacheQueries }
    single { get<Database>().bookQueries }
}

expect val platformModule: Module