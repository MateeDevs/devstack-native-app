package cz.matee.devstack.kmp.android.books.ui

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.*
import androidx.compose.material.pullrefresh.PullRefreshIndicator
import androidx.compose.material.pullrefresh.pullRefresh
import androidx.compose.material.pullrefresh.rememberPullRefreshState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.books.vm.BooksIntent
import cz.matee.devstack.kmp.android.books.vm.BooksViewModel
import cz.matee.devstack.kmp.android.shared.style.Values
import org.koin.androidx.compose.koinViewModel

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun BookListScreen(
    navHostController: NavHostController,
    viewModel: BooksViewModel = koinViewModel(),
) {
    val state by viewModel.collectState()
    val pullRefreshState = rememberPullRefreshState(
        refreshing = state.isLoading,
        onRefresh = { viewModel.onIntent(BooksIntent.LoadData) })

    Box(
        modifier = Modifier
            .padding(
                vertical = Values.Space.small,
            )
            .pullRefresh(
                state = pullRefreshState,
                enabled = !state.isLoading,
            )
    ) {
        LazyColumn(
            contentPadding = PaddingValues(
                horizontal = Values.Space.medium,
            ),
            modifier = Modifier
                .statusBarsPadding()
                .fillMaxSize()
        ) {
            items(state.books) { book ->
                Column {
                    Text(text = book.name)
                    Text(text = book.author)
                    Divider()
                }
            }
        }

        PullRefreshIndicator(
            refreshing = state.isLoading,
            state = pullRefreshState,
            modifier = Modifier
                .statusBarsPadding()
                .align(Alignment.TopCenter),
        )
    }
}
