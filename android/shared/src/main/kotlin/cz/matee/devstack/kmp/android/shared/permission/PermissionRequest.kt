package cz.matee.devstack.kmp.android.shared.permission

import android.content.pm.PackageManager
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.core.content.ContextCompat
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow

// https://gist.github.com/objcode/775fe45127fd40f17932f672ee203f72#file-permissions-kt-L78
// https://kotlinlang.slack.com/archives/CJLTWPH7S/p1590597865122200

private class PermissionCall(
    activity: ComponentActivity,
) {
    val granted = MutableStateFlow(false)

    val launcher = activity.registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted.value = it }

    fun unregister() {
        launcher.unregister()
    }
}

class PermissionRequest(
    val granted: StateFlow<Boolean>,
    private val permission: String,
    private val launcher: ActivityResultLauncher<String>
) {
    fun requestPermission() = launcher.launch(permission)
}

fun ComponentActivity.registerPermissionRequest(permission: String): PermissionRequest {
    val call = PermissionCall(this)
    lifecycle.addObserver(object : DefaultLifecycleObserver {
        override fun onCreate(owner: LifecycleOwner) {
            super.onCreate(owner)
            call.granted.value = ContextCompat.checkSelfPermission(
                this@registerPermissionRequest,
                permission
            ) == PackageManager.PERMISSION_GRANTED
        }

        override fun onDestroy(owner: LifecycleOwner) {
            super.onDestroy(owner)
            call.unregister()
        }
    })

    return PermissionRequest(call.granted.asStateFlow(), permission, call.launcher)
}

