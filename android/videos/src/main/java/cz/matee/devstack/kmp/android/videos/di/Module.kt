package cz.matee.devstack.kmp.android.videos.di

import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val booksModule = module {
    viewModel { BooksViewModel(get(), get()) }
}
