package kmp.android.profile

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import kmp.android.profile.ui.ProfileScreen
import kmp.android.shared.Feature

@Suppress("FunctionName")
fun NavGraphBuilder.ProfileRoot(navHostController: NavHostController) {
    composable(Feature.Profile.route) {
        ProfileScreen(navHostController)
    }
}
