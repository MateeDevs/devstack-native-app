package kmp.android.users.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.users.ui.navigateToUserDetail
import kmp.android.users.ui.userDetailRoute
import kmp.android.users.ui.userListRoute

fun NavGraphBuilder.usersNavGraph(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = UsersGraph.List.route,
        route = UsersGraph.rootPath,
    ) {
        userListRoute(
            navigateToUserDetail = { navHostController.navigateToUserDetail(it) },
        )

        userDetailRoute()
    }
}
