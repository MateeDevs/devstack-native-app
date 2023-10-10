package cz.matee.devstack.config

import com.android.build.api.dsl.CommonExtension
import cz.matee.devstack.constants.ProjectConstants
import cz.matee.devstack.extensions.libs
import org.gradle.api.Project

internal fun Project.configureKotlinAndroid(
    commonExtension: CommonExtension<*, *, *, *, *>,
) = with(commonExtension) {
    compileSdk = libs.versions.sdk.compile.get().toInt()

    defaultConfig {
        minSdk = libs.versions.sdk.min.get().toInt()
    }

    compileOptions {
        sourceCompatibility = ProjectConstants.javaVersion
        targetCompatibility = ProjectConstants.javaVersion
    }
}
