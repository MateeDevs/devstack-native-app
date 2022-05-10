package cz.matee.devstack.kmp.android.books.di

import cz.matee.devstack.kmp.android.books.vm.BooksViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val booksModule = module {
    viewModel { BooksViewModel(get(), get()) }
}