package cz.matee.devstack.kmp.android.users.ui

import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle
import cz.matee.devstack.kmp.android.shared.ui.UserProfileImage
import cz.matee.devstack.kmp.android.shared.util.composition.LocalScaffoldPadding
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.shared.util.extension.showIn
import cz.matee.devstack.kmp.android.users.R
import cz.matee.devstack.kmp.android.users.navigation.UsersDestination
import cz.matee.devstack.kmp.android.users.vm.UsersViewModel
import cz.matee.devstack.kmp.shared.domain.model.User

@Composable
fun UserDetailScreen(userId: String, navHostController: NavHostController) {
    val userVm = getViewModel<UsersViewModel>()
    val snackHost = remember { SnackbarHostState() }
    var user by remember { mutableStateOf<User?>(null) }
    val rootPadding = LocalScaffoldPadding.current

    userVm.errorFlow showIn snackHost

    LaunchedEffect(userVm) { user = userVm.getUser(userId) }

    val userData = user

    Box(
        Modifier
            .fillMaxSize()
            .padding(bottom = rootPadding.calculateBottomPadding())
    ) {

        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            ScreenTitle(UsersDestination.Detail.titleRes)

            Spacer(Modifier.height(Values.Space.xxlarge))

            if (userData != null)
                UserInformation(userData)
        }

        if (userData == null)
            CircularProgressIndicator(Modifier.align(Alignment.Center))

        SnackbarHost(snackHost, modifier = Modifier.align(Alignment.BottomCenter))
    }

}

@Composable
private fun UserInformation(user: User) {
    Column(horizontalAlignment = Alignment.CenterHorizontally) {

        if (user.firstName.isNotBlank() && user.lastName.isNotBlank()) {
            UserProfileImage(user)

            Spacer(Modifier.height(Values.Space.large))

            Text(
                text = "${user.firstName} ${user.lastName}",
                style = MaterialTheme.typography.h5,
                modifier = Modifier.padding(horizontal = Values.Space.large)
            )
        }

        if (user.bio.isNotBlank()) {
            Spacer(Modifier.height(Values.Space.small))
            Text(user.bio)
        }

        Divider(Modifier.padding(vertical = Values.Space.medium))

        Column(Modifier.fillMaxWidth().padding(horizontal = Values.Space.medium)) {
            Information(stringResource(R.string.user_detail_view_label_email), user.email)
            user.phone?.also { phoneNum ->
                Information(stringResource(R.string.user_detail_view_label_phone), phoneNum)
            }
        }
    }
}

@Composable
private fun Information(label: String, text: String) {
    Row {
        Text("$label:", fontWeight = FontWeight.Bold)
        Spacer(Modifier.width(Values.Space.small))
        Text(text)
    }
}