package cz.matee.devstack.kmp.android.profile

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import cz.matee.devstack.kmp.android.profile.ui.ProfileScreen
import cz.matee.devstack.kmp.android.shared.navigation.Feature

@Suppress("FunctionName")
fun NavGraphBuilder.ProfileRoot(navHostController: NavHostController) {
    composable(Feature.Profile.route) {
        ProfileScreen(navHostController)
    }
}