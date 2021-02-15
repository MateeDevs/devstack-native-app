package cz.matee.devstack.kmp.android.login

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.navigation
import cz.matee.devstack.kmp.android.login.navigation.LoginDestination
import cz.matee.devstack.kmp.android.login.ui.LoginScreen
import cz.matee.devstack.kmp.android.shared.navigation.Feature

fun NavGraphBuilder.LoginRoot(navHostController: NavHostController) {
    navigation(startDestination = LoginDestination.Login.route, Feature.Login.route) {
        composable(LoginDestination.Login.route) { LoginScreen(navHostController) }
        composable(LoginDestination.Registration.route) { }
    }
}