package kmp.android.profile.ui

import android.location.Location
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.requiredHeight
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.SnackbarHostState
import androidx.compose.material.Surface
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.navigation.NavController
import androidx.navigation.NavGraphBuilder
import kmp.android.profile.navigation.ProfileGraph
import kmp.android.profile.vm.ProfileViewModel
import kmp.android.shared.R
import kmp.android.shared.core.ui.util.rememberLocationPermissionRequest
import kmp.android.shared.core.util.get
import kmp.android.shared.extension.showIn
import kmp.android.shared.navigation.dialogDestination
import kmp.android.shared.style.Values
import kmp.android.shared.ui.ScreenTitle
import kmp.shared.domain.model.User
import org.koin.androidx.compose.getViewModel

fun NavController.navigateToEditProfile() {
    navigate(ProfileGraph.Edit())
}

internal fun NavGraphBuilder.editProfileRoute() {
    dialogDestination(
        destination = ProfileGraph.Edit,
    ) {
        EditProfileRoute()
    }
}

@Composable
internal fun EditProfileRoute(
    viewModel: ProfileViewModel = getViewModel(),
) {
    val snackHost = remember { SnackbarHostState() }
    val user by viewModel[ProfileViewModel.ViewState::user].collectAsState(null)
    val books by viewModel[ProfileViewModel.ViewState::books].collectAsState(listOf())
    val loading by viewModel[ProfileViewModel.ViewState::loading].collectAsState(false)
    var location by remember { mutableStateOf<Location?>(null) }

    val permissionHandler = rememberLocationPermissionRequest()
    val locationPermissionGranted by permissionHandler.granted

    LaunchedEffect(locationPermissionGranted) {
        if (locationPermissionGranted) {
            viewModel.getLocationFlow().collect {
                location = it
            }
        } else {
            permissionHandler.requestPermission()
        }
    }

    viewModel.errorFlow showIn snackHost

    EditProfileScreen(
        loading = loading,
        user = user,
        lastUser = viewModel.lastState().user,
        saveChanges = { viewModel.updateUser(it) },
    )
}

@Composable
private fun EditProfileScreen(
    loading: Boolean,
    user: User?,
    lastUser: User?,
    saveChanges: (User) -> Unit,
    modifier: Modifier = Modifier,
) {
    var editedUser by remember(user) { mutableStateOf(user) }

    val pendingChanges = lastUser != editedUser
    val saving = loading && pendingChanges

    Surface(modifier.padding(Values.Space.medium), shape = MaterialTheme.shapes.medium) {
        Column {
            ScreenTitle(
                R.string.profile_edit_view_title,
                background = MaterialTheme.colors.surface,
                statusBarPadding = false,
                showFade = false,
                modifier = Modifier.padding(top = Values.Space.medium),
            ) {
                Box(
                    Modifier
                        .fillMaxWidth()
                        .height(24.dp)
                        .padding(end = Values.Space.medium),
                ) {
                    if (saving) {
                        CircularProgressIndicator(modifier = Modifier.align(Alignment.CenterEnd))
                    } else if (pendingChanges) {
                        IconButton(
                            onClick = { editedUser?.let { saveChanges(it) } },
                            enabled = pendingChanges,
                            modifier = Modifier.align(Alignment.CenterEnd),
                        ) {
                            Icon(Icons.Filled.Check, "")
                        }
                    }
                }
            }

            Spacer(Modifier.requiredHeight(Values.Space.small))

            UserEdit(
                user = editedUser,
                onUserChange = {
                    editedUser = it
                },
            )
        }
    }
}
