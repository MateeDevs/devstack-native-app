package cz.matee.devstack.kmp.android.books.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.books.R
import cz.matee.devstack.kmp.android.books.vm.BooksIntent
import cz.matee.devstack.kmp.android.books.vm.BooksState
import cz.matee.devstack.kmp.android.books.vm.BooksViewModel
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel


@Composable
fun BookListScreen(navHostController: NavHostController, vm: BooksViewModel = getViewModel()) {
    LaunchedEffect(vm) {
        vm.onIntent(BooksIntent.ViewDidAppear)
    }
    //BookList(vm.state)
    BookListShimmer(vm.state)
}

@Composable
private fun BookList(state: BooksState) {
    val scaffoldState = rememberScaffoldState()
    Scaffold(
        modifier = Modifier.fillMaxSize(),
        scaffoldState = scaffoldState,
        topBar = {
            TopAppBar(
                modifier = Modifier.padding(top = 25.dp),
                title = {
                    Text(
                        text = stringResource(id = R.string.books_view_toolbar_title),
                        fontSize = 30.sp
                    )
                }
            )
        }
    ) {
        LazyColumn(
            modifier = Modifier.padding(bottom = 103.dp),
            contentPadding = PaddingValues(
                start = 12.dp,
                end = 12.dp,
                top = 9.dp,
                bottom = 9.dp
            )
        ) {
            items(items = state.books) { book ->
                BookListRow(name = book.name, author = book.author)
            }
        }
        Loading(state.loading)
    }
}

@Composable
private fun BookListShimmer(state: BooksState) {
    val scaffoldState = rememberScaffoldState()
    Scaffold(
        modifier = Modifier.fillMaxSize(),
        scaffoldState = scaffoldState,
        topBar = {
            TopAppBar(
                modifier = Modifier.padding(top = 25.dp),
                title = {
                    Text(
                        text = stringResource(id = R.string.books_view_toolbar_title),
                        fontSize = 30.sp
                    )
                }
            )
        }
    ) {
        if (state.loading) {
            LazyColumn(
                modifier = Modifier.padding(bottom = 103.dp),
                contentPadding = PaddingValues(
                    start = 12.dp,
                    end = 12.dp,
                    top = 9.dp,
                    bottom = 9.dp
                )
            ) {
                items(items = state.books) { book ->
                    ShimmerRow()
                }
            }
        } else {
            LazyColumn(
                modifier = Modifier.padding(bottom = 103.dp),
                contentPadding = PaddingValues(
                    start = 12.dp,
                    end = 12.dp,
                    top = 9.dp,
                    bottom = 9.dp
                )
            ) {
                items(items = state.books) { book ->
                    BookListRow(name = book.name, author = book.author)
                }
            }
        }
    }
}

@Composable
private fun Loading(isDisplayed: Boolean = false) {
    if (isDisplayed) {
        Box(
            modifier = Modifier
                .fillMaxSize()
                .background(color = Color.Gray.copy(alpha = 0.6F))
                .verticalScroll(
                    rememberScrollState()
                ),
            contentAlignment = Alignment.Center
        ) {
            CircularProgressIndicator(
                modifier = Modifier.padding(bottom = 80.dp),
                color = Color.White,
                strokeWidth = Dp(4F)
            )
        }
    }
}


@Preview
@Composable
fun Show() {
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(color = Color.Gray.copy(alpha = 0.6F))
            .verticalScroll(
                rememberScrollState()
            ),
        contentAlignment = Alignment.Center
    ) {
        CircularProgressIndicator(
            modifier = Modifier.padding(bottom = 40.dp),
            color = Color.White,
            strokeWidth = Dp(4F)
        )
    }
}