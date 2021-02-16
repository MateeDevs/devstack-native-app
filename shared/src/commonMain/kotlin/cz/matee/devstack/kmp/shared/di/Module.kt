package cz.matee.devstack.kmp.shared.di

import com.russhwolf.settings.Settings
import cz.matee.devstack.kmp.shared.data.repository.AuthRepositoryImpl
import cz.matee.devstack.kmp.shared.data.source.AuthSource
import cz.matee.devstack.kmp.shared.domain.repository.AuthRepository
import cz.matee.devstack.kmp.shared.domain.usecase.LoginUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.RegisterUseCase
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDao
import cz.matee.devstack.kmp.shared.infrastructure.local.AuthDaoImpl
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthService
import cz.matee.devstack.kmp.shared.infrastructure.remote.HttpClient
import cz.matee.devstack.kmp.shared.infrastructure.source.AuthSourceImpl
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
    factory { RegisterUseCase(get()) }

    // Repositories
    single<AuthRepository> { AuthRepositoryImpl(get()) }

    // Sources
    single<AuthSource> { AuthSourceImpl(get()) }

    // DAOs
    single<AuthDao> { AuthDaoImpl(get()) }

    // Http Services
    single { AuthService(get()) }
}

expect val platformModule: Module