package cz.matee.devstack.kmp.shared.di

import com.russhwolf.settings.Settings
import cz.matee.devstack.kmp.Database
import cz.matee.devstack.kmp.shared.data.repository.AuthRepositoryImpl
import cz.matee.devstack.kmp.shared.data.repository.UserRepositoryImpl
import cz.matee.devstack.kmp.shared.data.source.AuthSource
import cz.matee.devstack.kmp.shared.data.source.UserLocalSource
import cz.matee.devstack.kmp.shared.data.source.UserRemoteSource
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository
import cz.matee.devstack.kmp.shared.domain.repository.UserRepository
import cz.matee.devstack.kmp.shared.domain.usecase.DeleteAuthDataUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.user.*
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDaoImpl
import cz.matee.devstack.kmp.shared.infrastructure.local.createDatabase
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthService
import cz.matee.devstack.kmp.shared.infrastructure.remote.HttpClient
import cz.matee.devstack.kmp.shared.infrastructure.remote.UserService
import cz.matee.devstack.kmp.shared.infrastructure.source.AuthSourceImpl
import cz.matee.devstack.kmp.shared.infrastructure.source.UserLocalSourceImpl
import cz.matee.devstack.kmp.shared.infrastructure.source.UserRemoteSourceImpl
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.module

fun initKoin(appDeclaration: KoinAppDeclaration = {}) = startKoin {
    appDeclaration()
    modules(commonModule, platformModule)
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
    factory { GetUserUseCase(get()) }
    factory { IsUserLoggedInUseCase(get()) }
    factory { UpdateUserUseCase(get()) }
    factory { UpdateLocalUserCacheUseCase(get()) }
    factory { UserCacheChangeFlowUseCase(get()) }
    factory { ReplaceUserCacheWithUseCase(get()) }

    // Repositories
    single<AuthRepository> { AuthRepositoryImpl(get()) }
    single<UserRepository> { UserRepositoryImpl(get(), get(), get()) }

    // Sources
    single<AuthSource> { AuthSourceImpl(get(), get()) }
    single<UserRemoteSource> { UserRemoteSourceImpl(get()) }
    single<UserLocalSource> { UserLocalSourceImpl(get(), get()) }

    // DAOs
    single<AuthDao> { AuthDaoImpl(get()) }

    // Http Services
    single { AuthService(get()) }
    single { UserService(get()) }

    // Database
    single { createDatabase(get()) }
    single { get<Database>().userQueries }
    single { get<Database>().userCacheQueries }
}

expect val platformModule: Module