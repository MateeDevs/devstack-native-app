package kmp.android.login

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import kmp.android.login.ui.AuthScreen
import kmp.android.shared.Feature

fun NavGraphBuilder.LoginRoot(navHostController: NavHostController) {
    composable(Feature.Login.route) { AuthScreen(navHostController) }
}
