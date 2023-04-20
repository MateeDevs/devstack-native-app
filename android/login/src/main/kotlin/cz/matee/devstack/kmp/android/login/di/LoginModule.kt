package cz.matee.devstack.kmp.android.login.di

import cz.matee.devstack.kmp.android.login.vm.AuthViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val loginModule = module {
    viewModel { AuthViewModel(get(), get()) }
}
