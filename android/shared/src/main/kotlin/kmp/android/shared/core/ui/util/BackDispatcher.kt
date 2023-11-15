package kmp.android.shared.core.ui.util

import androidx.activity.OnBackPressedCallback
import androidx.activity.OnBackPressedDispatcher
import androidx.activity.compose.LocalOnBackPressedDispatcherOwner
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.navigation.NavHostController

/**
 * Overrides local [OnBackPressedDispatcher] when in composition
 *
 * @param navHostController [NavHostController] which back press dispatcher will be disabled
 * @param onBackPress Callback for onBackPressed action
 */
@Composable
public fun BackPressOverride(
    navHostController: NavHostController,
    onBackPress: () -> Unit,
) {
    val backDispatcher = LocalOnBackPressedDispatcherOwner.current?.onBackPressedDispatcher

    DisposableEffect(backDispatcher) {
        navHostController.enableOnBackPressed(false)

        val callback = object : OnBackPressedCallback(true) {
            override fun handleOnBackPressed() {
                onBackPress()
            }
        }

        backDispatcher?.addCallback(callback)

        onDispose {
            callback.remove()
            navHostController.enableOnBackPressed(true)
        }
    }
}
