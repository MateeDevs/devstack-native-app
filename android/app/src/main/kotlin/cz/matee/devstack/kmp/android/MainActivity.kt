package cz.matee.devstack.kmp.android

import android.os.Build
import android.os.Bundle
import android.view.View
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import cz.matee.devstack.kmp.android.di.initDependencyInjection
import cz.matee.devstack.kmp.android.shared.style.AppTheme
import cz.matee.devstack.kmp.android.ui.Root
import cz.matee.devstack.kmp.shared.infrastructure.remote.HttpClient
import dev.chrisbanes.accompanist.insets.ExperimentalAnimatedInsets
import dev.chrisbanes.accompanist.insets.ProvideWindowInsets

@OptIn(ExperimentalAnimatedInsets::class)
class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initDependencyInjection()
        goFullscreen()
    }

    override fun onStart() {
        super.onStart()
        setContent {
            AppTheme {
                ProvideWindowInsets(windowInsetsAnimationsEnabled = true) {
                    Root()
                }
            }
        }
    }

    override fun onDestroy() {
        HttpClient.close()
        super.onDestroy()
    }

    private fun goFullscreen() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
            window.setDecorFitsSystemWindows(false)
        else
            window.decorView.systemUiVisibility =
                View.SYSTEM_UI_FLAG_LAYOUT_STABLE or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
    }
}