package cz.matee.devstack.kmp.android

import android.Manifest
import android.os.Build
import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.runtime.CompositionLocalProvider
import androidx.core.view.WindowCompat
import cz.matee.devstack.kmp.android.di.initDependencyInjection
import cz.matee.devstack.kmp.android.shared.permission.registerPermissionRequest
import cz.matee.devstack.kmp.android.shared.style.AppTheme
import cz.matee.devstack.kmp.android.shared.util.composition.LocalLocationPermissionRequest
import cz.matee.devstack.kmp.android.ui.Root
import dev.chrisbanes.accompanist.insets.ExperimentalAnimatedInsets
import dev.chrisbanes.accompanist.insets.ProvideWindowInsets
import org.koin.core.context.GlobalContext

@OptIn(ExperimentalAnimatedInsets::class)
class MainActivity : AppCompatActivity() {

    private val locationPermissionRequest =
        registerPermissionRequest(Manifest.permission.ACCESS_FINE_LOCATION)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GlobalContext.getOrNull()
            ?: initDependencyInjection() // Init only if there is no context already

        WindowCompat.setDecorFitsSystemWindows(window, false)
    }

    override fun onStart() {
        super.onStart()
        setContent {
            // Domain util providers
            CompositionLocalProvider(LocalLocationPermissionRequest provides locationPermissionRequest) {

                AppTheme {
                    ProvideWindowInsets(
                        windowInsetsAnimationsEnabled = Build.VERSION.SDK_INT >= 30 // Turn on when adjustResize bug is fixed (https://issuetracker.google.com/issues/154101484)
                    ) {
                        Root()
                    }
                }
            }
        }
    }
}