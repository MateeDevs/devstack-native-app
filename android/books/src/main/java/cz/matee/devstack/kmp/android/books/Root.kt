package cz.matee.devstack.kmp.android.books

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.navigation
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.books.navigation.BooksDestinations
import cz.matee.devstack.kmp.android.books.ui.BookListScreen

@Suppress("FunctionName")
fun NavGraphBuilder.BooksRoot(navHostController: NavHostController) {
    navigation(startDestination = BooksDestinations.List.route, Feature.Books.route) {

        composable(BooksDestinations.List.route) { BookListScreen(navHostController) }

        composable(BooksDestinations.Detail.route) {

        }
    }
}