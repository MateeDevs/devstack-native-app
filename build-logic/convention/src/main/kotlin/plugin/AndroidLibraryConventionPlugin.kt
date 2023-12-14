package plugin

import com.android.build.api.dsl.LibraryExtension
import config.configureBuildVariants
import config.configureKotlinAndroid
import extensions.apply
import extensions.implementation
import extensions.libs
import extensions.pluginManager
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies

class AndroidLibraryConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            pluginManager {
                apply(libs.plugins.serialization)
                apply(libs.plugins.ktlint)
                apply(libs.plugins.android.library)
            }

            apply<KotlinConventionPlugin>()

            extensions.configure<LibraryExtension> {
                configureKotlinAndroid(this)
                configureBuildVariants()

                buildFeatures {
                    buildConfig = false
                }
            }

            dependencies {
                implementation(libs.lifecycle.runtime)
                implementation(libs.bundles.sqlDelight.common)
                implementation(libs.koin.core)
                implementation(libs.koin.android)
            }

//            apply<LoggingConvention>()
//            apply<NetworkConvention>()
//            apply<FirebaseConvention>()
//            apply<AndroidBaseConvention>()
//            apply<NetworkConvention>()
        }
    }
}
