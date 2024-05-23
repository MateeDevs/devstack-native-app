package kmp.android.videos.di

import kmp.android.videos.vm.VideosViewModel
import org.koin.android.ext.koin.androidApplication
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val videosModule = module {
    viewModel { VideosViewModel(androidApplication(), get()) }
}
