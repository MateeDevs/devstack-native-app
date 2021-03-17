package cz.matee.devstack.kmp.android.shared.util.composition

import androidx.activity.OnBackPressedCallback
import androidx.activity.compose.LocalOnBackPressedDispatcherOwner
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.navigation.NavHostController

@Composable
fun OverrideNavigationBackPressDispatcher(
    navHostController: NavHostController,
    onBackPress: () -> Unit
) {
    val backDispatcher = LocalOnBackPressedDispatcherOwner.current.onBackPressedDispatcher

    DisposableEffect(backDispatcher) {
        navHostController.enableOnBackPressed(false)
        val callback = object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                onBackPress()
            }
        }
        backDispatcher.addCallback(callback)

        onDispose {
            callback.remove()
            navHostController.enableOnBackPressed(true)
        }
    }
}