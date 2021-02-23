package cz.matee.devstack.kmp.android.shared.util.composition

import androidx.compose.runtime.compositionLocalOf
import cz.matee.devstack.kmp.android.shared.permission.PermissionRequest

val LocalLocationPermissionRequest = compositionLocalOf<PermissionRequest> {
    error("Location permission request handler has not been initialized")
}