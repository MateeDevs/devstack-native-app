package cz.matee.devstack.kmp.android.shared.di

import cz.matee.devstack.kmp.android.shared.base.error.ErrorMessageProviderImpl
import cz.matee.devstack.kmp.shared.base.error.ErrorMessageProvider
import org.koin.dsl.module

val androidSharedModule = module {
    single<ErrorMessageProvider> { ErrorMessageProviderImpl(get()) }
}