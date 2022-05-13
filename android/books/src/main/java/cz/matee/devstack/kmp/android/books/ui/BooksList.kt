package cz.matee.devstack.kmp.android.books.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.books.vm.BooksViewModel

@Composable
fun BookListScreen(navHostController: NavHostController) {
    val vm = getViewModel<BooksViewModel>()
    Column(modifier = Modifier.padding(top = 100.dp)) {
        Text(text = "Books")
    }
}
