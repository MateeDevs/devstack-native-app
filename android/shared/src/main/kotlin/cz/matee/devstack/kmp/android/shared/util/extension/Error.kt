package cz.matee.devstack.kmp.android.shared.util.extension

import android.annotation.SuppressLint
import androidx.compose.material.SnackbarHostState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.error.ErrorMessageProvider
import cz.matee.devstack.kmp.shared.base.error.getMessage
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import org.koin.androidx.compose.get

@SuppressLint("ComposableNaming")
@Composable
infix fun Flow<ErrorResult>.showIn(snackHost: SnackbarHostState) {
    val errorMessageProvider: ErrorMessageProvider = get()
    LaunchedEffect(this, snackHost) {
        collect { error ->
            snackHost.showSnackbar(errorMessageProvider.getMessage(error))
        }
    }
}
