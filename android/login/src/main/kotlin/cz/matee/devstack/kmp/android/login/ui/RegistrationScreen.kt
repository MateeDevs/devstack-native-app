package cz.matee.devstack.kmp.android.login.ui

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.Surface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.ui.Modifier
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.ui.LocalSnackBarBehavior

@Composable
fun RegistrationScreen(navHostController: NavHostController) {
    val scope = rememberCoroutineScope()
    val snackBar = LocalSnackBarBehavior.current


    Surface(modifier = Modifier.fillMaxSize()) {

    }
}