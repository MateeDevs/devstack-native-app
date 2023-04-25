package cz.matee.devstack.kmp.android.login

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import cz.matee.devstack.kmp.android.login.ui.AuthScreen
import cz.matee.devstack.kmp.android.shared.navigation.Feature

fun NavGraphBuilder.LoginRoot(navHostController: NavHostController) {
    composable(Feature.Login.route) { AuthScreen(navHostController) }
}
