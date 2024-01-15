package kmp.android.profile.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.navigation
import kmp.android.profile.ui.editProfileRoute
import kmp.android.profile.ui.navigateToEditProfile
import kmp.android.profile.ui.profileRoute

fun NavGraphBuilder.profileNavGraph(
    navHostController: NavHostController,
    navigateToLogin: () -> Unit,
) {
    navigation(
        startDestination = ProfileGraph.Home.route,
        route = ProfileGraph.rootPath,
    ) {
        profileRoute(
            navigateToEditProfile = { navHostController.navigateToEditProfile() },
            navigateToLogin = navigateToLogin,
        )

        editProfileRoute()
    }
}
