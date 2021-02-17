package cz.matee.devstack.kmp.android.users.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.padding
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.users.navigation.UsersDestination
import cz.matee.devstack.kmp.android.users.vm.UsersViewModel
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.UserData
import dev.chrisbanes.accompanist.insets.statusBarsPadding

@Composable
fun UserList(navHostController: NavHostController) {
    val userVm = getViewModel<UsersViewModel>()
    val users = remember { mutableStateListOf<UserData>() }

    LaunchedEffect(userVm) {
        when (val res = userVm.getUsers()) {
            is Result.Success -> users.addAll(res.data.users)
            is Result.Error -> {
            }
        }
    }

    Text(
        stringResource(UsersDestination.List.titleRes),
        style = MaterialTheme.typography.h3,
        modifier = Modifier.statusBarsPadding().padding(start = Values.Space.medium)
    )

    Column {
        users.forEach {
            Surface(modifier = Modifier.padding(Values.Space.medium)) {
                Text(it.email)
            }
        }
    }

}