package cz.matee.devstack.kmp.android.shared.ui

import androidx.compose.material.SnackbarDuration
import androidx.compose.material.SnackbarResult
import androidx.compose.runtime.compositionLocalOf

val LocalSnackBarBehavior =
    compositionLocalOf<SnackBarBehaviorProvider> { throw NullPointerException("No snack host") }

interface SnackBarBehaviorProvider {
    suspend fun showSnackbar(
        message: String,
        actionLabel: String? = null,
        duration: SnackbarDuration = SnackbarDuration.Short
    ): SnackbarResult?
}