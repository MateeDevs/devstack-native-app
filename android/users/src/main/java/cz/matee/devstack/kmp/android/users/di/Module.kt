package cz.matee.devstack.kmp.android.users.di

import cz.matee.devstack.kmp.android.users.vm.UsersViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val usersModule = module {
    viewModel { UsersViewModel(get(), get()) }
}