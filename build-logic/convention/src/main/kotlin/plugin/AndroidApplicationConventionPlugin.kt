package plugin

import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import config.configureApplicationVariants
import config.configureBuildVariants
import config.configureKotlinAndroid
import config.configureSingingConfigs
import config.configureTwine
import constants.Application
import extensions.apply
import extensions.implementation
import extensions.libs
import extensions.pluginManager
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.dependencies

class AndroidApplicationConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            pluginManager {
                apply(libs.plugins.android.application)
                apply(libs.plugins.serialization)
                apply(libs.plugins.ktlint)
                apply(libs.plugins.android.application)
            }

            apply<KotlinConventionPlugin>()

            extensions.configure<BaseAppModuleExtension> {
                configureKotlinAndroid(this)

                defaultConfig {
                    minSdk = libs.versions.sdk.min.get().toInt()
                    compileSdk = libs.versions.sdk.compile.get().toInt()
                    targetSdk = libs.versions.sdk.target.get().toInt()

                    applicationId = Application.id
                    versionName = Application.Version.name
                    versionCode = Application.Version.code
                    vectorDrawables.useSupportLibrary = true
                }

                buildFeatures {
                    buildConfig = false
                }

                buildTypes {
                    debug { }
                }

                configureBuildVariants()
                configureSingingConfigs(this)
                configureApplicationVariants()
            }

            configureTwine()

            dependencies {
                implementation(libs.material)
                implementation(libs.androidX.core)
                implementation(libs.lifecycle.runtime)
                implementation(libs.bundles.sqlDelight.common)
                implementation(libs.koin.core)
                implementation(libs.koin.android)
            }
        }
    }
}
