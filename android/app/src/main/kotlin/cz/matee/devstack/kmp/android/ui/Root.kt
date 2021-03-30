package cz.matee.devstack.kmp.android.ui

import androidx.compose.animation.*
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Build
import androidx.compose.material.icons.filled.List
import androidx.compose.material.icons.filled.Person
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.*
import com.google.accompanist.insets.navigationBarsPadding
import cz.matee.devstack.kmp.android.login.LoginRoot
import cz.matee.devstack.kmp.android.profile.ProfileRoot
import cz.matee.devstack.kmp.android.recipes.RecipesRoot
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.util.composition.LocalScaffoldPadding
import cz.matee.devstack.kmp.android.shared.util.extension.get
import cz.matee.devstack.kmp.android.users.UsersRoot
import cz.matee.devstack.kmp.shared.domain.usecase.user.IsUserLoggedInUseCase

val navBarFeatures = listOf(
    Feature.Users, Feature.Profile, Feature.Recipes
)

@Composable
fun Root() {
    val navController = rememberNavController()
    val isUserLoggedInUseCase = get<IsUserLoggedInUseCase>()
    var isUserLoggedIn by remember { mutableStateOf<Boolean?>(null) }

    LaunchedEffect(isUserLoggedInUseCase) {
        isUserLoggedIn = isUserLoggedInUseCase()
    }

    val showLogin = isUserLoggedIn?.not()

    Scaffold(
        bottomBar = { BottomBar(navController) },
    ) {
        if (showLogin != null)
            CompositionLocalProvider(LocalScaffoldPadding provides it) {
                NavHost(
                    navController,
                    startDestination = if (showLogin) Feature.Login.route else Feature.Users.route
                ) {
                    LoginRoot(navController)
                    UsersRoot(navController)
                    ProfileRoot(navController)
                    RecipesRoot(navController)
                }
            }
    }
}

@OptIn(ExperimentalAnimationApi::class)
@Composable
private fun BottomBar(navController: NavHostController) {
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.arguments?.getString(KEY_ROUTE)

    // Don't show NavBar on start
    val isInAuthRoute = currentRoute?.startsWith(Feature.Login.route) ?: true

    AnimatedVisibility(
        visible = !isInAuthRoute,
        enter = fadeIn() + expandVertically(),
        exit = fadeOut() + shrinkVertically()
    ) {
        Surface(
            elevation = Values.Elevation.huge,
            color = MaterialTheme.colors.primarySurface
        ) {
            BottomNavigation(
                Modifier.navigationBarsPadding(),
                elevation = 0.dp
            ) {
                navBarFeatures.forEach { screen ->
                    BottomNavigationItem(
                        icon = {
                            when (screen) {
                                Feature.Users -> Icon(Icons.Filled.List, "")
                                Feature.Profile -> Icon(Icons.Filled.Person, "")
                                Feature.Recipes -> Icon(Icons.Filled.Build, "")
                                else -> error("Icon not handled for ${screen.route}")
                            }
                        },
                        label = { Text(stringResource(screen.titleRes)) },
                        selected = currentRoute?.startsWith(screen.route) ?: false,
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
    }
}