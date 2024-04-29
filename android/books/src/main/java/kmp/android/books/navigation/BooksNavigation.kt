package kmp.android.books.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.books.ui.bookListRoute

fun NavGraphBuilder.booksNavGraph(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = BooksGraph.List.route,
        route = BooksGraph.rootPath,
    ) {
        bookListRoute()
    }
}
