package kmp.android.profile.di

import kmp.android.profile.vm.ProfileViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val profileModule = module {
    viewModel { ProfileViewModel(get(), get(), get(), get(), get(), get()) }
}
