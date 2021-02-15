package cz.matee.devstack.kmp.android.login.ui

import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.ui.LocalSnackBarBehavior

@Composable
private fun RegistrationScreen(navHostController: NavHostController) {
    val scope = rememberCoroutineScope()
    val snackBar = LocalSnackBarBehavior.current


}