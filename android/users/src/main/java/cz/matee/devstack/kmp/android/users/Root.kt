package cz.matee.devstack.kmp.android.users

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.navigation
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.users.navigation.UsersDestination
import cz.matee.devstack.kmp.android.users.ui.UserDetailScreen
import cz.matee.devstack.kmp.android.users.ui.UserListScreen

@Suppress("FunctionName")
fun NavGraphBuilder.UsersRoot(navHostController: NavHostController) {
    navigation(startDestination = UsersDestination.List.route, Feature.Users.route) {
        composable(UsersDestination.List.route) { UserListScreen(navHostController) }

        composable(UsersDestination.Detail.route) {
            val userId = it.arguments?.getString(UsersDestination.Detail.userIdArgument)
                ?: error("User ID needs to be passed to User Detail")
            UserDetailScreen(userId, navHostController)
        }
    }
}
