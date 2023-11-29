package kmp.android.books.navigation

import androidx.annotation.StringRes
import kmp.android.shared.R

sealed class BooksDestinations(val route: String, @StringRes val titleRes: Int) {
    object List : BooksDestinations("books/list", R.string.books_view_toolbar_title)
    object Detail :
        BooksDestinations("books/detail/{userId}", R.string.books_view_toolbar_title) {
        const val bookIdArgument = "bookId"
        fun withBook(id: String) = "books/detail/$id"
    }
}
