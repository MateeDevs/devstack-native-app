package kmp.android.ui

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.expandVertically
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.shrinkVertically
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.material.BottomNavigation
import androidx.compose.material.BottomNavigationItem
import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Scaffold
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Build
import androidx.compose.material.icons.filled.List
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.primarySurface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import kmp.android.books.navigation.booksNavGraph
import kmp.android.login.navigation.LoginDestination
import kmp.android.login.navigation.loginNavGraph
import kmp.android.navigation.NavBarFeature
import kmp.android.profile.navigation.profileNavGraph
import kmp.android.recipes.navigation.recipesNavGraph
import kmp.android.shared.style.Values
import kmp.android.users.navigation.UsersDestination
import kmp.android.users.navigation.usersNavGraph
import kmp.shared.base.util.extension.getOrNull
import kmp.shared.domain.usecase.user.IsUserLoggedInUseCase
import org.koin.androidx.compose.get

@Composable
fun Root(modifier: Modifier = Modifier) {
    val navController = rememberNavController()
    val isUserLoggedInUseCase = get<IsUserLoggedInUseCase>()
    var isUserLoggedIn by remember { mutableStateOf<Boolean?>(null) }

    LaunchedEffect(isUserLoggedInUseCase) {
        isUserLoggedIn = isUserLoggedInUseCase().getOrNull()
    }

    val showLogin = isUserLoggedIn?.not()

    Scaffold(
        modifier = modifier,
        bottomBar = { BottomBar(navController) },
    ) { padding ->
        Box(modifier = Modifier.padding(padding)) {
            if (showLogin != null) {
                NavHost(
                    navController,
                    startDestination = if (showLogin) LoginDestination.route else UsersDestination.route,
                ) {
                    loginNavGraph(
                        navHostController = navController,
                        navigateToUsers = { navController.navigate(UsersDestination.route) },
                    )
                    usersNavGraph(navController)
                    profileNavGraph(
                        navHostController = navController,
                        navigateToLogin = { navController.navigate(LoginDestination.route) },
                    )
                    recipesNavGraph(navController)
                    booksNavGraph(navController)
                }
            }
        }
    }
}

@Composable
private fun BottomBar(navController: NavHostController) {
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    // Don't show NavBar on start
    val isInAuthRoute = currentRoute?.startsWith(LoginDestination.route) ?: true

    AnimatedVisibility(
        visible = !isInAuthRoute,
        enter = fadeIn() + expandVertically(),
        exit = fadeOut() + shrinkVertically(),
    ) {
        Surface(
            elevation = Values.Elevation.huge,
            color = MaterialTheme.colors.primarySurface,
        ) {
            BottomNavigation(
                Modifier.navigationBarsPadding(),
                elevation = 0.dp,
            ) {
                NavBarFeature.values().forEach { screen ->
                    BottomNavigationItem(
                        icon = {
                            when (screen) {
                                NavBarFeature.Users -> Icon(Icons.Filled.List, "")
                                NavBarFeature.Profile -> Icon(Icons.Filled.Person, "")
                                NavBarFeature.Recipes -> Icon(Icons.Filled.Build, "")
                                NavBarFeature.Books -> Icon(Icons.Filled.Build, "")
                            }
                        },
                        label = { Text(stringResource(screen.titleRes)) },
                        selected = currentRoute?.startsWith(screen.route) ?: false,
                        onClick = {
                            navController.navigate(screen.route) {
                                popUpTo(navController.graph.startDestinationId)
                                launchSingleTop = true
                            }
                        },
                    )
                }
            }
        }
    }
}
