package kmp.android.shared.extension

import android.annotation.SuppressLint
import androidx.compose.material.SnackbarHostState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import kmp.shared.base.ErrorResult
import kmp.shared.base.error.ErrorMessageProvider
import kmp.shared.base.error.getMessage
import kotlinx.coroutines.flow.Flow
import org.koin.androidx.compose.get

@SuppressLint("ComposableNaming")
@Suppress("konsist.every internal or public compose function has a modifier")
@Composable
infix fun Flow<ErrorResult>.showIn(snackHost: SnackbarHostState) {
    val errorMessageProvider: ErrorMessageProvider = get()
    LaunchedEffect(this, snackHost) {
        collect { error ->
            snackHost.showSnackbar(errorMessageProvider.getMessage(error))
        }
    }
}
