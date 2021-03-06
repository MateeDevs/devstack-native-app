package cz.matee.devstack.kmp.android.profile.ui

import android.location.Location
import androidx.compose.foundation.layout.*
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Edit
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.navigation.NavHostController
import com.example.profile.R
import cz.matee.and.core.ui.util.LocalLocationPermissionHandler
import cz.matee.and.core.util.get
import cz.matee.devstack.kmp.android.profile.vm.ProfileViewModel
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle
import cz.matee.devstack.kmp.android.shared.util.composition.LocalScaffoldPadding
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.shared.util.extension.showIn
import cz.matee.devstack.kmp.shared.domain.model.User
import kotlinx.coroutines.flow.collect
import cz.matee.devstack.kmp.android.profile.vm.ProfileViewModel.ViewState as State

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun ProfileScreen(
    navHostController: NavHostController,
    profileVm: ProfileViewModel = getViewModel()
) {
    val parentPadding = LocalScaffoldPadding.current
    val snackHost = remember { SnackbarHostState() }
    var editDialogVisible by remember { mutableStateOf(false) }
    val user by profileVm[State::user].collectAsState(null)
    val books by profileVm[State::books].collectAsState(listOf())

    profileVm.errorFlow showIn snackHost

    Box(
        Modifier
            .fillMaxSize()
            .padding(bottom = parentPadding.calculateBottomPadding())
    ) {
        val loading by profileVm[State::loading].collectAsState(false)

        ProfileLayout(
            onEditClick = { editDialogVisible = true },
        ) {
            val permissionHandler = LocalLocationPermissionHandler.current
            var locationValue by remember { mutableStateOf<Location?>(null) }
            val locationPermissionGranted by permissionHandler.granted

            LaunchedEffect(locationPermissionGranted) {
                if (locationPermissionGranted)
                    profileVm.getLocationFlow().collect {
                        locationValue = it
                    }
                else
                    permissionHandler.requestPermission()
            }


            @Suppress("UnnecessaryVariable")
            val userData = user
            if (userData != null)
                ProfileContent(
                    userData,
                    books,
                    locationValue,
                    refreshBooks = { profileVm.reloadBooks() },
                    onLogOut = { profileVm.logOut(navHostController) },
                )
        }

        if (loading)
            CircularProgressIndicator(Modifier.align(Alignment.Center))

        SnackbarHost(snackHost, Modifier.align(Alignment.BottomCenter))
    }

    if (editDialogVisible)
        Dialog(onDismissRequest = { editDialogVisible = false }) {
            EditUserScreen(user, profileVm = profileVm)
        }
}

@Composable
private fun ProfileLayout(
    onEditClick: () -> Unit,
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit
) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = modifier) {

        ScreenTitle(R.string.profile_view_toolbar_title) {
            Row(Modifier.fillMaxWidth(), Arrangement.End) {
                IconButton(
                    onClick = onEditClick,
                    Modifier.padding(end = Values.Space.medium)
                ) {
                    Icon(Icons.Filled.Edit, "")
                }
            }
        }
        content()
    }
}

@Composable
private fun EditUserScreen(
    user: User?,
    modifier: Modifier = Modifier,
    profileVm: ProfileViewModel = getViewModel()
) {
    val loading by profileVm[State::loading].collectAsState(false)
    var editedUser by remember(user) { mutableStateOf(user) }

    val pendingChanges = profileVm.lastState().user != editedUser
    val saving = loading && pendingChanges

    fun saveChanges() {
        editedUser?.let(profileVm::updateUser)
    }

    Surface(modifier.padding(Values.Space.medium), shape = MaterialTheme.shapes.medium) {
        Column {
            ScreenTitle(
                R.string.profile_edit_view_title,
                background = MaterialTheme.colors.surface,
                statusBarPadding = false,
                showFade = false,
                modifier = Modifier.padding(top = Values.Space.medium)
            ) {
                Box(
                    Modifier
                        .fillMaxWidth()
                        .height(24.dp)
                        .padding(end = Values.Space.medium)
                ) {
                    if (saving)
                        CircularProgressIndicator(modifier = Modifier.align(Alignment.CenterEnd))
                    else if (pendingChanges)
                        IconButton(
                            onClick = ::saveChanges,
                            enabled = pendingChanges,
                            modifier = Modifier.align(Alignment.CenterEnd)
                        ) {
                            Icon(Icons.Filled.Check, "")
                        }
                }
            }

            Spacer(Modifier.requiredHeight(Values.Space.small))

            UserEdit(editedUser) {
                editedUser = it
            }
        }
    }
}