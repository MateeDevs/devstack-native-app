package cz.matee.devstack.plugin

import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import cz.matee.devstack.config.configureApplicationVariants
import cz.matee.devstack.config.configureBuildVariants
import cz.matee.devstack.config.configureKotlinAndroid
import cz.matee.devstack.config.configureSingingConfigs
import cz.matee.devstack.config.configureTwine
import cz.matee.devstack.constants.Application
import cz.matee.devstack.extensions.apply
import cz.matee.devstack.extensions.implementation
import cz.matee.devstack.extensions.libs
import cz.matee.devstack.extensions.pluginManager
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
