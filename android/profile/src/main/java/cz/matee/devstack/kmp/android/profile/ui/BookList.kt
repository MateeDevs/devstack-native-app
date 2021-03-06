package cz.matee.devstack.kmp.android.profile.ui

import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.shared.domain.model.Book
import kotlinx.coroutines.launch

@Composable
fun BookList(
    books: List<Book>,
    refreshBooks: suspend () -> Unit,
    modifier: Modifier = Modifier
) {
    val scope = rememberCoroutineScope()

    Column(modifier) {
        Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
            Text(
                "Books",
                style = MaterialTheme.typography.h5,
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(0.1f)
                    .padding(start = Values.Space.mediumLarge)
            )
            IconButton(
                onClick = { scope.launch { refreshBooks() } },
                modifier = Modifier
                    .padding(horizontal = Values.Space.medium, vertical = Values.Space.small)
            ) {
                Icon(imageVector = Icons.Default.Refresh, contentDescription = "Refresh")
            }
        }

        LazyRow(Modifier.fillMaxSize()) {
            items(books) {
                BookItem(book = it)
            }
        }
    }
}

@Composable
private fun BookItem(book: Book) {
    Box(
        modifier = Modifier
            .padding(Values.Space.small)
            .border(Values.Border.thin, MaterialTheme.colors.secondary, MaterialTheme.shapes.small)
    ) {
        Column(Modifier.padding(Values.Space.medium)) {
            Text(book.name, style = MaterialTheme.typography.h6)
            Text(book.author, style = MaterialTheme.typography.subtitle2)

            Spacer(Modifier.height(Values.Space.small))

            Text(
                book.pages.toString(),
                style = MaterialTheme.typography.caption,
                modifier = Modifier.align(Alignment.End)
            )
        }
    }
}