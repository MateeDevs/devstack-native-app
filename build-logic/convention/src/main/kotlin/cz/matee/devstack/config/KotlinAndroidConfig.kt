package cz.matee.devstack.config

import com.android.build.api.dsl.CommonExtension
import cz.matee.devstack.constants.ProjectConstants
import cz.matee.devstack.extensions.kotlinOptions
import cz.matee.devstack.extensions.libs
import org.gradle.api.Project

internal fun Project.configureKotlinAndroid(
    commonExtension: CommonExtension<*, *, *, *>,
) = with(commonExtension) {
    compileSdk = libs.versions.sdk.compile.get().toInt()

    defaultConfig {
        minSdk = libs.versions.sdk.min.get().toInt()
    }

    kotlinOptions {
        freeCompilerArgs = freeCompilerArgs + listOf(
            // Here add all compose experimental options used in the app
//            "-opt-in=androidx.compose.animation.ExperimentalAnimationApi",
//            "-opt-in=androidx.lifecycle.compose.ExperimentalLifecycleComposeApi",
//            "-opt-in=androidx.compose.ui.ExperimentalComposeUiApi",
//            "-opt-in=androidx.compose.foundation.ExperimentalFoundationApi",
//            "-opt-in=androidx.compose.material.ExperimentalMaterialApi",
        )

        jvmTarget = ProjectConstants.javaVersion.toString()
    }

    compileOptions {
        sourceCompatibility = ProjectConstants.javaVersion
        targetCompatibility = ProjectConstants.javaVersion
    }
}
