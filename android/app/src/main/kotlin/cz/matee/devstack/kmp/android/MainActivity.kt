package cz.matee.devstack.kmp.android

import android.os.Build
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.compose.runtime.CompositionLocalProvider
import androidx.core.view.WindowCompat
import cz.matee.devstack.kmp.android.shared.core.system.BaseActivity
import cz.matee.devstack.kmp.android.shared.core.ui.util.LocalLocationPermissionHandler
import cz.matee.devstack.kmp.android.shared.core.ui.util.rememberLocationPermissionRequest
import cz.matee.devstack.kmp.android.di.initDependencyInjection
import cz.matee.devstack.kmp.android.shared.style.AppTheme
import cz.matee.devstack.kmp.android.ui.Root
import org.koin.core.context.GlobalContext

class MainActivity : BaseActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GlobalContext.getOrNull()
            ?: initDependencyInjection() // Init only if there is no context already

        WindowCompat.setDecorFitsSystemWindows(window, false)
    }

    override fun onStart() {
        super.onStart()
        setContent {
            val locationPermissionRequest = rememberLocationPermissionRequest()

            // Providers
            AppTheme {
                    CompositionLocalProvider(
                        LocalLocationPermissionHandler provides locationPermissionRequest
                    ) {

                        // The App
                        Root()

                    }
            }
        }
    }
}