package kmp.android.books.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import kmp.android.books.vm.BooksViewModel
import org.koin.androidx.compose.getViewModel

@Composable
fun BookListScreen(navHostController: NavHostController, modifier: Modifier = Modifier) {
    val vm = getViewModel<BooksViewModel>()
    Column(modifier = modifier.padding(top = 100.dp)) {
        Text(text = "Books")
    }
}
