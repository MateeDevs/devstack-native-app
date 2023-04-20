package cz.matee.devstack.kmp.android.books.navigation

import androidx.annotation.StringRes
import cz.matee.devstack.kmp.android.books.R

sealed class BooksDestinations(val route: String, @StringRes val titleRes: Int) {
    object List : BooksDestinations("books/list", cz.matee.devstack.kmp.android.shared.R.string.books_view_toolbar_title)
    object Detail :
        BooksDestinations("books/detail/{userId}", cz.matee.devstack.kmp.android.shared.R.string.books_view_toolbar_title) {
        const val bookIdArgument = "bookId"
        fun withBook(id: String) = "books/detail/$id"
    }
}