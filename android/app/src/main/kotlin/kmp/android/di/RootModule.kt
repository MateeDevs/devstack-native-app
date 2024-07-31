package kmp.android.di

import android.content.Context
import androidx.activity.ComponentActivity
import kmp.android.sample.di.androidSampleModule
import kmp.android.shared.di.androidSharedModule
import kmp.shared.core.di.initKoin
import org.koin.dsl.module

fun ComponentActivity.initDependencyInjection() {
    initKoin {
        val contextModule = module { // Provide Android Context
            factory<ComponentActivity> { this@initDependencyInjection }
            factory<Context> { this@initDependencyInjection }
        }

        modules(
            contextModule,
            androidSharedModule,
            androidSampleModule,
        )
    }
}
