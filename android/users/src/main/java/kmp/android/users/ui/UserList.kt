package kmp.android.users.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.Divider
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavGraphBuilder
import androidx.paging.compose.LazyPagingItems
import androidx.paging.compose.collectAsLazyPagingItems
import androidx.paging.compose.itemContentType
import androidx.paging.compose.itemKey
import kmp.android.shared.R
import kmp.android.shared.navigation.composableDestination
import kmp.android.shared.style.Values
import kmp.android.shared.ui.ScreenTitle
import kmp.android.users.navigation.UsersGraph
import kmp.android.users.vm.UsersViewModel
import kmp.shared.domain.model.UserPagingData
import org.koin.androidx.compose.getViewModel

internal fun NavGraphBuilder.userListRoute(
    navigateToUserDetail: (String) -> Unit,
) {
    composableDestination(
        destination = UsersGraph.List,
    ) {
        UserListRoute(
            navigateToUserDetail = navigateToUserDetail,
        )
    }
}

@Composable
internal fun UserListRoute(
    navigateToUserDetail: (String) -> Unit,
    viewModel: UsersViewModel = getViewModel(),
) {
    val users = viewModel.users.collectAsLazyPagingItems()

    UserListScreen(
        users = users,
        onUserTapped = { navigateToUserDetail(it.id) },
    )
}

@Composable
private fun UserListScreen(
    users: LazyPagingItems<UserPagingData>,
    onUserTapped: (UserPagingData) -> Unit,
    modifier: Modifier = Modifier,
) {
    Column(modifier = modifier) {
        ScreenTitle(R.string.users_view_toolbar_title) {
            Row(Modifier.fillMaxWidth(), Arrangement.End) {
                IconButton(
                    onClick = { users.refresh() },
                    modifier = Modifier.padding(end = Values.Space.medium),
                ) {
                    Icon(Icons.Filled.Refresh, "refresh")
                }
            }
        }

        LazyColumn {
            items(
                count = users.itemCount,
                key = users.itemKey(),
                contentType = users.itemContentType(),
            ) { index ->
                val userData = users[index]
                if (userData != null) {
                    UserItem(userData, onClick = { onUserTapped(userData) })
                }
            }

            item { // Space at bottom of the list
                Spacer(
                    Modifier.height(Values.Space.medium),
                )
            }
        }
    }
}

@Composable
fun UserItem(data: UserPagingData, onClick: () -> Unit, modifier: Modifier = Modifier) {
    Box(
        modifier = Modifier
            .fillMaxWidth()
            .clickable(onClick = onClick),
    ) {
        Divider()
        Text(data.email, Modifier.padding(Values.Space.medium))
    }
}
