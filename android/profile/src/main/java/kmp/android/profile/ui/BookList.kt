package kmp.android.profile.ui

import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import kmp.android.shared.style.Values
import kmp.shared.domain.model.Book
import kotlinx.collections.immutable.ImmutableList

@Composable
fun BookList(
    books: ImmutableList<Book>,
    refreshBooks: () -> Unit,
    modifier: Modifier = Modifier,
) {
    Column(modifier) {
        Row(Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
            Text(
                "Books",
                style = MaterialTheme.typography.h5,
                modifier = Modifier
                    .fillMaxWidth()
                    .weight(0.1f)
                    .padding(start = Values.Space.mediumLarge),
            )
            IconButton(
                onClick = { refreshBooks() },
                modifier = Modifier
                    .padding(horizontal = Values.Space.medium, vertical = Values.Space.small),
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
            .border(Values.Border.thin, MaterialTheme.colors.secondary, MaterialTheme.shapes.small),
    ) {
        Column(Modifier.padding(Values.Space.medium)) {
            Text(book.name, style = MaterialTheme.typography.h6)
            Text(book.author, style = MaterialTheme.typography.subtitle2)

            Spacer(Modifier.height(Values.Space.small))

            Text(
                book.pages.toString(),
                style = MaterialTheme.typography.caption,
                modifier = Modifier.align(Alignment.End),
            )
        }
    }
}
