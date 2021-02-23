package cz.matee.devstack.kmp.android.profile.ui

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material.icons.filled.Edit
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import com.example.profile.R
import cz.matee.and.core.util.extension.get
import cz.matee.devstack.kmp.android.profile.vm.ProfileViewModel
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle
import cz.matee.devstack.kmp.android.shared.util.composition.LocalScaffoldPadding
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.shared.util.extension.showIn
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.android.profile.vm.ProfileViewModel.ViewState as State

@OptIn(ExperimentalMaterialApi::class)
@Composable
fun ProfileScreen(
    navHostController: NavHostController,
    profileVm: ProfileViewModel = getViewModel()
) {
    val parentPadding = LocalScaffoldPadding.current
    val snackHost = remember { SnackbarHostState() }
    val sheetState = rememberModalBottomSheetState(ModalBottomSheetValue.Hidden)
    val user by profileVm[State::user].collectAsState(null)

    profileVm.errorFlow showIn snackHost

    ModalBottomSheetLayout(
        sheetContent = {
            BottomSheetContent(user, profileVm = profileVm)
        },
        sheetState = sheetState,
        sheetShape = RoundedCornerShape(
            topStart = Values.Radius.large,
            topEnd = Values.Radius.large
        ),
        modifier = Modifier.padding(bottom = parentPadding.calculateBottomPadding())
    ) {
        Box(Modifier.fillMaxSize()) {
            val loading by profileVm[State::loading].collectAsState(false)

            Content(
                user,
                onEdit = { sheetState.show() },
                onLogOut = { profileVm.logOut(navHostController) },
                profileVm = profileVm
            )

            if (loading)
                CircularProgressIndicator(Modifier.align(Alignment.Center))

            SnackbarHost(snackHost, Modifier.align(Alignment.BottomCenter))
        }
    }
}

@Composable
private fun Content(
    user: User?,
    onEdit: () -> Unit,
    onLogOut: () -> Unit,
    modifier: Modifier = Modifier,
    profileVm: ProfileViewModel = getViewModel()
) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = modifier) {

        ScreenTitle(R.string.profile_view_toolbar_title) {
            Row(Modifier.fillMaxWidth(), Arrangement.End) {
                IconButton(
                    onClick = onEdit,
                    Modifier.padding(end = Values.Space.medium)
                ) {
                    Icon(Icons.Filled.Edit, "")
                }
            }
        }

        Spacer(Modifier.height(Values.Space.small))

        if (user != null)
            ProfileContent(
                user,
                onLogOut = onLogOut,
                profileVm
            )
    }
}

@Composable
private fun BottomSheetContent(
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

    ScreenTitle(R.string.profile_view_toolbar_title, background = MaterialTheme.colors.surface) {
        Row(
            horizontalArrangement = Arrangement.End,
            modifier = Modifier.fillMaxWidth().padding(end = Values.Space.medium)
        ) {
            if (saving)
                CircularProgressIndicator()
            else
                IconButton(
                    onClick = ::saveChanges,
                    enabled = pendingChanges,
                ) {
                    Icon(Icons.Filled.Check, "")
                }
        }
    }


    EditUserBottomSheetContent(editedUser) {
        editedUser = it
    }
}