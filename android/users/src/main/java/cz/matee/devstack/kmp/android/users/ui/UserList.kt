package cz.matee.devstack.kmp.android.users.ui

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigate
import androidx.paging.compose.collectAsLazyPagingItems
import androidx.paging.compose.items
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle
import cz.matee.devstack.kmp.android.shared.util.composition.LocalScaffoldPadding
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.users.navigation.UsersDestination
import cz.matee.devstack.kmp.android.users.vm.UsersViewModel
import cz.matee.devstack.kmp.shared.domain.model.UserData

@Composable
fun UserListScreen(navHostController: NavHostController) {
    val userVm = getViewModel<UsersViewModel>()
    val users = userVm.users.collectAsLazyPagingItems()
    val rootPadding = LocalScaffoldPadding.current

    fun onUserItemClick(user: UserData) {
        navHostController.navigate(UsersDestination.Detail.withUser(user.id))
    }

    Column {
        ScreenTitle(UsersDestination.List.titleRes) {
            Row(Modifier.fillMaxWidth(), Arrangement.End) {
                IconButton(
                    onClick = { users.refresh() },
                    modifier = Modifier.padding(end = Values.Space.medium)
                ) {
                    Icon(Icons.Filled.Refresh, "refresh")
                }
            }
        }

        LazyColumn {
            items(users) { userData ->
                if (userData != null)
                    UserItem(userData) { onUserItemClick(userData) }
                else LinearProgressIndicator(
                    color = MaterialTheme.colors.surface,
                    modifier = Modifier
                        .fillMaxWidth()
                        .height(Values.Space.xxlarge)
                )
            }

            item { // Space at bottom of the list
                Spacer(
                    Modifier.height(
                        Values.Space.medium + rootPadding.calculateBottomPadding()
                    )
                )
            }
        }
    }

}

@Composable
fun UserItem(data: UserData, onClick: () -> Unit) {
    Box(modifier = Modifier.fillMaxWidth().clickable(onClick = onClick)) {
        Divider()
        Text(data.email, Modifier.padding(Values.Space.medium))
    }
}