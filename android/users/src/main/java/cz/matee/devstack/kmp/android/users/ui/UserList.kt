package cz.matee.devstack.kmp.android.users.ui

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
import androidx.navigation.NavHostController
import androidx.paging.compose.collectAsLazyPagingItems
import androidx.paging.compose.items
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle
import cz.matee.devstack.kmp.android.users.navigation.UsersDestination
import cz.matee.devstack.kmp.android.users.vm.UsersViewModel
import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import org.koin.androidx.compose.getViewModel

@Composable
fun UserListScreen(navHostController: NavHostController, modifier: Modifier = Modifier) {
    val userVm = getViewModel<UsersViewModel>()
    val users = userVm.users.collectAsLazyPagingItems()

    fun onUserItemClick(user: UserPagingData) {
        navHostController.navigate(UsersDestination.Detail.withUser(user.id))
    }

    Column(modifier = modifier) {
        ScreenTitle(UsersDestination.List.titleRes) {
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
            items(users) { userData ->
                if (userData != null) {
                    UserItem(userData, onClick = { onUserItemClick(userData) })
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
