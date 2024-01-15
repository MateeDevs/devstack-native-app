package kmp.android.books.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavGraphBuilder
import kmp.android.books.navigation.BooksGraph
import kmp.android.books.vm.BooksIntent
import kmp.android.books.vm.BooksViewModel
import kmp.android.shared.navigation.composableDestination
import org.koin.androidx.compose.getViewModel

internal fun NavGraphBuilder.bookListRoute() {
    composableDestination(
        destination = BooksGraph.List,
    ) {
        BookListRoute()
    }
}

@Composable
internal fun BookListRoute(
    viewModel: BooksViewModel = getViewModel(),
) {
    BookListScreen(onIntent = { viewModel.onIntent(it) })
}

@Composable
private fun BookListScreen(onIntent: (BooksIntent) -> Unit, modifier: Modifier = Modifier) {
    Column(modifier = modifier.padding(top = 100.dp)) {
        Text(text = "Books")
    }
}
