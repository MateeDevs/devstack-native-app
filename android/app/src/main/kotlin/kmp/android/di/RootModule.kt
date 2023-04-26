package kmp.android.di

import android.app.Application
import android.content.Context
import androidx.activity.ComponentActivity
import kmp.android.books.di.booksModule
import kmp.android.login.di.loginModule
import kmp.android.profile.di.profileModule
import kmp.android.shared.di.androidSharedModule
import kmp.android.users.di.usersModule
import kmp.android.videos.di.videosModule
import kmp.shared.di.initKoin
import org.koin.dsl.module

fun ComponentActivity.initDependencyInjection() {
    initKoin {
        val contextModule = module { // Provide Android Context
            factory<ComponentActivity> { this@initDependencyInjection }
            factory<Context> { this@initDependencyInjection }
            factory<Application> { this@initDependencyInjection.application }
        }

        modules(
            contextModule,
            androidSharedModule,
            loginModule,
            profileModule,
            usersModule,
            booksModule,
            videosModule,
        )
    }
}
