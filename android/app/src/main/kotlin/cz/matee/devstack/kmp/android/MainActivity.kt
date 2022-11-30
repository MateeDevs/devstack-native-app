package cz.matee.devstack.kmp.android

import android.os.Build
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.compose.runtime.CompositionLocalProvider
import androidx.core.view.WindowCompat
import com.google.accompanist.insets.ExperimentalAnimatedInsets
import com.google.accompanist.insets.ProvideWindowInsets
import cz.matee.devstack.kmp.android.shared.core.system.BaseActivity
import cz.matee.devstack.kmp.android.shared.core.ui.util.LocalLocationPermissionHandler
import cz.matee.devstack.kmp.android.shared.core.ui.util.rememberLocationPermissionRequest
import cz.matee.devstack.kmp.android.di.initDependencyInjection
import cz.matee.devstack.kmp.android.shared.style.AppTheme
import cz.matee.devstack.kmp.android.ui.Root
import org.koin.core.context.GlobalContext

@OptIn(ExperimentalAnimatedInsets::class)
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
                ProvideWindowInsets(
                    windowInsetsAnimationsEnabled = Build.VERSION.SDK_INT >= 30 // Turn on when adjustResize bug is fixed (https://issuetracker.google.com/issues/154101484)
                ) {
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
}