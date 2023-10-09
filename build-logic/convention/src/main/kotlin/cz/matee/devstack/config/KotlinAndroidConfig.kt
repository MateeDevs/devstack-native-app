package cz.matee.devstack.config

import com.android.build.api.dsl.CommonExtension
import cz.matee.devstack.constants.ProjectConstants
import cz.matee.devstack.extensions.kotlinOptions
import cz.matee.devstack.extensions.libs
import org.gradle.api.Project

internal fun Project.configureKotlinAndroid(
    commonExtension: CommonExtension<*, *, *, *, *>,
) = with(commonExtension) {
    compileSdk = libs.versions.sdk.compile.get().toInt()

    defaultConfig {
        minSdk = libs.versions.sdk.min.get().toInt()
    }

    // TODO: https://youtrack.jetbrains.com/issue/KTIJ-24271
//    kotlinOptions {
//        jvmTarget = ProjectConstants.javaVersion.toString()
//    }

    compileOptions {
        sourceCompatibility = ProjectConstants.javaVersion
        targetCompatibility = ProjectConstants.javaVersion
    }
}
