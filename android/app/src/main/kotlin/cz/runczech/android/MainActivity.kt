package cz.runczech.android

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.core.view.WindowCompat
import cz.runczechandroid.di.initDependencyInjection
import org.koin.core.context.GlobalContext

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
//            val locationPermissionRequest = rememberLocationPermissionRequest()
//
//            // Providers
//            AppTheme {
//                    CompositionLocalProvider(
//                        LocalLocationPermissionHandler provides locationPermissionRequest
//                    ) {
//
//                        // The App
//                        Root()
//
//                    }
//            }
        }
    }
}