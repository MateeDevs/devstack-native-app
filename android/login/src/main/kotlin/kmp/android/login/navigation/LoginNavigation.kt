package kmp.android.login.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import kmp.android.login.ui.authRoute

fun NavGraphBuilder.loginNavGraph(
    navHostController: NavHostController,
    navigateToUsers: () -> Unit,
) {
    authRoute(
        navHostController = navHostController,
        navigateToUsers = navigateToUsers,
    )
}
