package kmp.android

import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.core.view.WindowCompat
import kmp.android.di.initDependencyInjection
import kmp.android.shared.core.system.BaseActivity
import kmp.android.shared.style.AppTheme
import kmp.android.ui.Root
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
            AppTheme {
                Root()
            }
        }
    }
}
