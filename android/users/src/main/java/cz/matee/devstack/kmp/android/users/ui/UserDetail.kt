package cz.matee.devstack.kmp.android.users.ui

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.height
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.users.navigation.UsersDestination
import cz.matee.devstack.kmp.android.users.vm.UsersViewModel
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.User

@Composable
fun UserDetail(userId: String, navHostController: NavHostController) {
    val userVm = getViewModel<UsersViewModel>()
    var user by remember { mutableStateOf<User?>(null) }

    LaunchedEffect(userVm) {
        when (val res = userVm.getUser(userId)) {
            is Result.Success -> user = res.data
            is Result.Error -> {
            }
        }
    }

    val userData = user

    Column(horizontalAlignment = Alignment.CenterHorizontally) {
        ScreenTitle(UsersDestination.Detail.titleRes)

        Spacer(Modifier.height(Values.Space.xxlarge))

        if (userData != null) {
            Box(Modifier) {
                Text("${userData.firstName[0]}${userData.lastName[0]}")
            }
        } else CircularProgressIndicator()


    }

}