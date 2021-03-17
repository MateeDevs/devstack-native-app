package cz.matee.devstack.kmp.android.shared.permission

import android.Manifest
import androidx.activity.compose.registerForActivityResult
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.runtime.*

@Composable
fun ProvidePermissionRequest(content: @Composable () -> Unit) {
    var granted by remember { mutableStateOf(false) }
    val launcher = registerForActivityResult(
        contract = ActivityResultContracts.RequestPermission(),
        onResult = { granted = it }
    )

    val locationRequest = remember {
        LocationPermissionRequest(
            launcher,
            derivedStateOf { granted }
        )
    }

    CompositionLocalProvider(LocalLocationPermissionHandler provides locationRequest) {
        content()
    }
}

val LocalLocationPermissionHandler = compositionLocalOf<LocationPermissionRequest> { error("") }

class LocationPermissionRequest(
    private val launcher: ActivityResultLauncher<String>,
    val granted: State<Boolean>
) {
    fun requestLocationPermission(): Unit =
        launcher.launch(Manifest.permission.ACCESS_FINE_LOCATION)
}