package cz.runczechandroid.di

import android.content.Context
import androidx.activity.ComponentActivity
import cz.runczech.shared.di.initKoin
import org.koin.dsl.module

fun ComponentActivity.initDependencyInjection() {
    initKoin {
        val contextModule = module { // Provide Android Context
            factory<ComponentActivity> { this@initDependencyInjection }
            factory<Context> { this@initDependencyInjection }
        }

        modules(
            contextModule
        )
    }
}