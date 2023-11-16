package config

import com.android.build.api.dsl.CommonExtension
import constants.ProjectConstants
import extensions.libs
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
