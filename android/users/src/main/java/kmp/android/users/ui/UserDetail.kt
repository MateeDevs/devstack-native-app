package kmp.android.users.ui

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Divider
import androidx.compose.material.MaterialTheme
import androidx.compose.material.SnackbarHost
import androidx.compose.material.SnackbarHostState
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.navigation.NavHostController
import kmp.android.shared.R
import kmp.android.shared.extension.showIn
import kmp.android.shared.style.Values
import kmp.android.shared.ui.ScreenTitle
import kmp.android.shared.ui.UserProfileImage
import kmp.android.users.navigation.UsersDestination
import kmp.android.users.vm.UsersViewModel
import kmp.shared.domain.model.User
import org.koin.androidx.compose.getViewModel

@Composable
fun UserDetailScreen(userId: String, navHostController: NavHostController, modifier: Modifier = Modifier) {
    val userVm = getViewModel<UsersViewModel>()
    val snackHost = remember { SnackbarHostState() }
    var user by remember { mutableStateOf<User?>(null) }

    userVm.errorFlow showIn snackHost

    LaunchedEffect(userId) {
        userVm.getUser(userId).collect { user = it }
    }

    val userData = user

    Box(
        modifier.fillMaxSize(),
    ) {
        Column(horizontalAlignment = Alignment.CenterHorizontally) {
            ScreenTitle(UsersDestination.Detail.titleRes)

            Spacer(Modifier.height(Values.Space.xxlarge))

            if (userData != null) {
                UserInformation(userData)
            }
        }

        if (userData == null) {
            CircularProgressIndicator(Modifier.align(Alignment.Center))
        }

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
                modifier = Modifier.padding(horizontal = Values.Space.large),
            )
        }

        if (user.bio.isNotBlank()) {
            Spacer(Modifier.height(Values.Space.small))
            Text(user.bio)
        }

        Divider(Modifier.padding(vertical = Values.Space.medium))

        Column(
            Modifier
                .fillMaxWidth()
                .padding(horizontal = Values.Space.medium),
        ) {
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
