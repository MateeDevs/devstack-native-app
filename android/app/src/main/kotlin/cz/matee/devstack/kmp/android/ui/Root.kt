package cz.matee.devstack.kmp.android.ui

import androidx.compose.animation.core.animateIntAsState
import androidx.compose.foundation.layout.offset
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.*
import cz.matee.devstack.kmp.android.login.LoginRoot
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.shared.ui.LocalSnackBarBehavior
import cz.matee.devstack.kmp.android.shared.ui.SnackBarBehaviorProvider
import dev.chrisbanes.accompanist.insets.navigationBarsPadding

val navBarFeatures = listOf(
    Feature.Profile, Feature.Users, Feature.Counter
)

@Composable
fun Root() {
    val navController = rememberNavController()
    var snackBarHost by remember { mutableStateOf<SnackbarHostState?>(null) }

    val snackBarProvider = remember(snackBarHost) {
        object : SnackBarBehaviorProvider {
            override suspend fun showSnackbar(
                message: String,
                actionLabel: String?,
                duration: SnackbarDuration
            ): SnackbarResult? = snackBarHost?.showSnackbar(message, actionLabel, duration)
        }
    }

    Scaffold(
        bottomBar = { BottomBar(navController) },
        snackbarHost = {
            snackBarHost = it
            SnackbarHost(it)
        }
    ) {
        Providers(LocalSnackBarBehavior provides snackBarProvider) {

            NavHost(navController, startDestination = Feature.Login.route) {
                LoginRoot(navController)

                composable(Feature.Profile.route) { Text("PROFILE") }
                composable(Feature.Users.route) { Text(text = "USERS") }
                composable(Feature.Counter.route) { Text(text = "COUNTER") }
            }

        }
    }
}

@Composable
private fun BottomBar(navController: NavHostController) {
    var bottomBarHeight by remember { mutableStateOf(0) }
    val visible = navController.currentDestination?.label == Feature.Login.route

    val offsetY by animateIntAsState(if (visible) 0 else bottomBarHeight)

    BottomNavigation(
        Modifier
            .navigationBarsPadding()
            .onGloballyPositioned { bottomBarHeight = it.size.height }
            .offset(y = offsetY.dp)
    ) {
        val navBackStackEntry by navController.currentBackStackEntryAsState()
        val currentRoute = navBackStackEntry?.arguments?.getString(KEY_ROUTE)
        navBarFeatures.forEach { screen ->
            BottomNavigationItem(
                icon = { Icon(Icons.Filled.Favorite, "") },
                label = { Text(stringResource(screen.titleRes)) },
                selected = currentRoute == screen.route,
                onClick = {
                    navController.navigate(screen.route) {
                        popUpTo = navController.graph.startDestination
                        launchSingleTop = true
                    }
                }
            )
        }
    }
}