package kmp.android.profile.ui

import android.location.Location
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.SnackbarHost
import androidx.compose.material.SnackbarHostState
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Edit
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.navigation.NavGraphBuilder
import kmp.android.profile.navigation.ProfileGraph
import kmp.android.profile.vm.ProfileViewModel
import kmp.android.shared.R
import kmp.android.shared.core.ui.util.rememberLocationPermissionRequest
import kmp.android.shared.core.util.get
import kmp.android.shared.extension.showIn
import kmp.android.shared.navigation.composableDestination
import kmp.android.shared.style.Values
import kmp.android.shared.ui.ScreenTitle
import kmp.shared.domain.model.Book
import kmp.shared.domain.model.User
import kotlinx.collections.immutable.toImmutableList
import org.koin.androidx.compose.getViewModel
import kmp.android.profile.vm.ProfileViewModel.ViewState as State

internal fun NavGraphBuilder.profileRoute(
    navigateToEditProfile: () -> Unit,
    navigateToLogin: () -> Unit,
) {
    composableDestination(
        destination = ProfileGraph.Home,
    ) {
        ProfileRoute(
            navigateToEditProfile = navigateToEditProfile,
            navigateToLogin = navigateToLogin,
        )
    }
}

@Composable
internal fun ProfileRoute(
    navigateToEditProfile: () -> Unit,
    navigateToLogin: () -> Unit,
    viewModel: ProfileViewModel = getViewModel(),
) {
    val snackHost = remember { SnackbarHostState() }
    val user by viewModel[State::user].collectAsState(null)
    val books by viewModel[State::books].collectAsState(listOf())
    val loading by viewModel[State::loading].collectAsState(false)
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

    ProfileScreen(
        loading = loading,
        user = user,
        location = location,
        books = books,
        snackHost = snackHost,
        reloadBooks = { viewModel.reloadBooks() },
        logOut = { viewModel.logOut(navigateToLogin) },
        openEdit = navigateToEditProfile,
    )
}

@Composable
private fun ProfileScreen(
    loading: Boolean,
    user: User?,
    location: Location?,
    books: List<Book>,
    snackHost: SnackbarHostState,
    reloadBooks: () -> Unit,
    logOut: () -> Unit,
    openEdit: () -> Unit,
    modifier: Modifier = Modifier,
) {
    Box(
        modifier.fillMaxSize(),
    ) {
        ProfileLayout(
            onEditClick = openEdit,
        ) {
            @Suppress("UnnecessaryVariable")
            val userData = user
            if (userData != null) {
                ProfileContent(
                    userData,
                    books.toImmutableList(),
                    location,
                    refreshBooks = reloadBooks,
                    onLogOut = logOut,
                )
            }
        }

        if (loading) {
            CircularProgressIndicator(Modifier.align(Alignment.Center))
        }

        SnackbarHost(snackHost, Modifier.align(Alignment.BottomCenter))
    }
}

@Composable
private fun ProfileLayout(
    onEditClick: () -> Unit,
    modifier: Modifier = Modifier,
    content: @Composable () -> Unit,
) {
    Column(horizontalAlignment = Alignment.CenterHorizontally, modifier = modifier) {
        ScreenTitle(R.string.profile_view_toolbar_title) {
            Row(Modifier.fillMaxWidth(), Arrangement.End) {
                IconButton(
                    onClick = onEditClick,
                    Modifier.padding(end = Values.Space.medium),
                ) {
                    Icon(Icons.Filled.Edit, "")
                }
            }
        }
        content()
    }
}
