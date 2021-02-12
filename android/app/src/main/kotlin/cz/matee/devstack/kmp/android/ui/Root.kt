package cz.matee.devstack.kmp.android.ui

import androidx.annotation.StringRes
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.navigation.NavHostController
import androidx.navigation.compose.*
import cz.matee.devstack.kmp.android.shared.R
import dev.chrisbanes.accompanist.insets.LocalWindowInsets
import dev.chrisbanes.accompanist.insets.navigationBarsPadding

sealed class Screen(val route: String, @StringRes val resourceId: Int) {
    object Profile : Screen("profile", R.string.bottom_bar_item_1)
    object Users : Screen("users", R.string.bottom_bar_item_2)
    object Counter : Screen("counter", R.string.bottom_bar_item_3)
}

val screens = listOf(
    Screen.Profile, Screen.Users, Screen.Counter
)

@Composable
fun Root() {
    val navController = rememberNavController()
    Scaffold(bottomBar = { BottomBar(navController) }) {
        Surface {
            NavHost(navController, startDestination = "profile") {
                composable(Screen.Profile.route) { Text("PROFILE") }
                composable(Screen.Users.route) { Text(text = "USERS") }
                composable(Screen.Counter.route) { Text(text = "COUNTER") }
            }
        }
    }
}

@Composable
private fun BottomBar(navController: NavHostController) {
    val insets = LocalWindowInsets.current

    BottomNavigation(Modifier.navigationBarsPadding()) {
        val navBackStackEntry by navController.currentBackStackEntryAsState()
        val currentRoute = navBackStackEntry?.arguments?.getString(KEY_ROUTE)
        screens.forEach { screen ->
            BottomNavigationItem(
                icon = { Icon(Icons.Filled.Favorite, "") },
                label = { Text(stringResource(screen.resourceId)) },
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