package kmp.android.shared.core.ui.util

import android.Manifest
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.runtime.Composable
import androidx.compose.runtime.State
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember

public abstract class PermissionRequest(
    protected open val launcher: ActivityResultLauncher<String>,
    public open val granted: State<Boolean>,
) {
    public abstract fun requestPermission()
}

@Composable
private fun <T : PermissionRequest> rememberPermissionRequest(
    factory: (
        launcher: ActivityResultLauncher<String>,
        granted: State<Boolean>,
    ) -> T,
): T {
    val granted = remember { mutableStateOf(false) }
    val launcher = rememberLauncherForActivityResult(
        contract = ActivityResultContracts.RequestPermission(),
        onResult = { granted.value = it },
    )

    return remember { factory(launcher, granted) }
}

// === Specific permissions ===

public class LocationPermissionRequest(
    launcher: ActivityResultLauncher<String>,
    granted: State<Boolean>,
) : PermissionRequest(launcher, granted) {
    public override fun requestPermission(): Unit =
        launcher.launch(Manifest.permission.ACCESS_FINE_LOCATION)
}

@Composable
public fun rememberLocationPermissionRequest(): LocationPermissionRequest =
    rememberPermissionRequest(::LocationPermissionRequest)
