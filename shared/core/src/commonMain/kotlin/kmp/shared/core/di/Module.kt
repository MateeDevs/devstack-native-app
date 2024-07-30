package kmp.shared.core.di

import com.russhwolf.settings.Settings
import kmp.Database
import kmp.shared.core.data.repository.AuthRepositoryImpl
import kmp.shared.core.data.repository.BookRepositoryImpl
import kmp.shared.core.data.repository.UserRepositoryImpl
import kmp.shared.core.data.source.AuthSource
import kmp.shared.core.data.source.BookLocalSource
import kmp.shared.core.data.source.UserLocalSource
import kmp.shared.core.data.source.UserRemoteSource
import kmp.shared.core.domain.repository.AuthRepository
import kmp.shared.core.domain.repository.BookRepository
import kmp.shared.core.domain.repository.UserRepository
import kmp.shared.core.domain.usecase.DeleteAuthDataUseCase
import kmp.shared.core.domain.usecase.DeleteAuthDataUseCaseImpl
import kmp.shared.core.domain.usecase.LoginUseCase
import kmp.shared.core.domain.usecase.LoginUseCaseImpl
import kmp.shared.core.domain.usecase.RegisterUseCase
import kmp.shared.core.domain.usecase.RegisterUseCaseImpl
import kmp.shared.core.domain.usecase.book.GetBooksUseCase
import kmp.shared.core.domain.usecase.book.GetBooksUseCaseImpl
import kmp.shared.core.domain.usecase.book.RefreshBooksUseCase
import kmp.shared.core.domain.usecase.book.RefreshBooksUseCaseImpl
import kmp.shared.core.domain.usecase.user.GetLocalUsersUseCase
import kmp.shared.core.domain.usecase.user.GetLocalUsersUseCaseImpl
import kmp.shared.core.domain.usecase.user.GetLoggedInUserUseCase
import kmp.shared.core.domain.usecase.user.GetLoggedInUserUseCaseImpl
import kmp.shared.core.domain.usecase.user.GetRemoteUsersUseCase
import kmp.shared.core.domain.usecase.user.GetRemoteUsersUseCaseImpl
import kmp.shared.core.domain.usecase.user.GetUserUseCase
import kmp.shared.core.domain.usecase.user.GetUserUseCaseImpl
import kmp.shared.core.domain.usecase.user.GetUsersUseCase
import kmp.shared.core.domain.usecase.user.GetUsersUseCaseImpl
import kmp.shared.core.domain.usecase.user.IsUserLoggedInUseCase
import kmp.shared.core.domain.usecase.user.IsUserLoggedInUseCaseImpl
import kmp.shared.core.domain.usecase.user.RefreshUsersUseCase
import kmp.shared.core.domain.usecase.user.RefreshUsersUseCaseImpl
import kmp.shared.core.domain.usecase.user.ReplaceUserCacheWithUseCase
import kmp.shared.core.domain.usecase.user.ReplaceUserCacheWithUseCaseImpl
import kmp.shared.core.domain.usecase.user.UpdateLocalUserCacheUseCase
import kmp.shared.core.domain.usecase.user.UpdateLocalUserCacheUseCaseImpl
import kmp.shared.core.domain.usecase.user.UpdateUserUseCase
import kmp.shared.core.domain.usecase.user.UpdateUserUseCaseImpl
import kmp.shared.core.domain.usecase.user.UserCacheChangeFlowUseCase
import kmp.shared.core.domain.usecase.user.UserCacheChangeFlowUseCaseImpl
import kmp.shared.core.infrastructure.local.AuthDao
import kmp.shared.core.infrastructure.local.AuthDaoImpl
import kmp.shared.core.infrastructure.local.createDatabase
import kmp.shared.core.infrastructure.remote.AuthService
import kmp.shared.core.infrastructure.remote.HttpClient
import kmp.shared.core.infrastructure.remote.UserService
import kmp.shared.core.infrastructure.source.AuthSourceImpl
import kmp.shared.core.infrastructure.source.BookLocalSourceImpl
import kmp.shared.core.infrastructure.source.UserLocalSourceImpl
import kmp.shared.core.infrastructure.source.UserRemoteSourceImpl
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
    single { HttpClient.init(get(), get(), get()) }
    single { Settings() }

    // UseCases
    factory<LoginUseCase> { LoginUseCaseImpl(get()) }
    factory<DeleteAuthDataUseCase> { DeleteAuthDataUseCaseImpl(get()) }
    factory<RegisterUseCase> { RegisterUseCaseImpl(get()) }
    factory<GetLoggedInUserUseCase> { GetLoggedInUserUseCaseImpl(get()) }
    factory<GetRemoteUsersUseCase> { GetRemoteUsersUseCaseImpl(get()) }
    factory<GetLocalUsersUseCase> { GetLocalUsersUseCaseImpl(get()) }
    factory<GetUsersUseCase> { GetUsersUseCaseImpl(get()) }
    factory<RefreshUsersUseCase> { RefreshUsersUseCaseImpl(get()) }
    factory<GetUserUseCase> { GetUserUseCaseImpl(get()) }
    factory<IsUserLoggedInUseCase> { IsUserLoggedInUseCaseImpl(get()) }
    factory<UpdateUserUseCase> { UpdateUserUseCaseImpl(get()) }
    factory<UpdateLocalUserCacheUseCase> { UpdateLocalUserCacheUseCaseImpl(get()) }
    factory<UserCacheChangeFlowUseCase> { UserCacheChangeFlowUseCaseImpl(get()) }
    factory<ReplaceUserCacheWithUseCase> { ReplaceUserCacheWithUseCaseImpl(get()) }
    factory<GetBooksUseCase> { GetBooksUseCaseImpl(get()) }
    factory<RefreshBooksUseCase> { RefreshBooksUseCaseImpl(get()) }

    // Repositories
    single<AuthRepository> { kmp.shared.core.data.repository.AuthRepositoryImpl(get()) }
    single<BookRepository> { kmp.shared.core.data.repository.BookRepositoryImpl(get()) }
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
