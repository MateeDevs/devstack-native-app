package cz.matee.devstack.kmp.android.di

import android.content.Context
import androidx.activity.ComponentActivity
import cz.matee.devstack.kmp.android.books.di.booksModule
import cz.matee.devstack.kmp.android.login.di.loginModule
import cz.matee.devstack.kmp.android.profile.di.profileModule
import cz.matee.devstack.kmp.android.shared.di.androidSharedModule
import cz.matee.devstack.kmp.android.users.di.usersModule
import cz.matee.devstack.kmp.shared.di.initKoin
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
            loginModule,
            profileModule,
            usersModule,
            booksModule
        )
    }
}