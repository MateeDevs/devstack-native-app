package kmp.android.users.di

import kmp.android.users.data.UserPagingMediator
import kmp.android.users.data.UsersPagingSource
import kmp.android.users.vm.UsersViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val usersModule = module {
    single { UserPagingMediator(get(), get(), get()) }
    factory { UsersPagingSource(get(), get()) }
    viewModel { UsersViewModel({ get() }, get(), get()) }
}
