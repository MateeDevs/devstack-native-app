package cz.matee.devstack.kmp.android

import android.os.Build
import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.view.WindowCompat
import cz.matee.devstack.kmp.android.di.initDependencyInjection
import cz.matee.devstack.kmp.android.shared.permission.ProvidePermissionRequest
import cz.matee.devstack.kmp.android.shared.style.AppTheme
import cz.matee.devstack.kmp.android.ui.Root
import dev.chrisbanes.accompanist.insets.ExperimentalAnimatedInsets
import dev.chrisbanes.accompanist.insets.ProvideWindowInsets
import org.koin.core.context.GlobalContext

@OptIn(ExperimentalAnimatedInsets::class)
class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GlobalContext.getOrNull()
            ?: initDependencyInjection() // Init only if there is no context already

        WindowCompat.setDecorFitsSystemWindows(window, false)
    }

    override fun onStart() {
        super.onStart()
        setContent {
            // Providers
            AppTheme {
                ProvideWindowInsets(
                    windowInsetsAnimationsEnabled = Build.VERSION.SDK_INT >= 30 // Turn on when adjustResize bug is fixed (https://issuetracker.google.com/issues/154101484)
                ) {
                    ProvidePermissionRequest {

                        // The App
                        Root()

                    }
                }
            }
        }
    }
}