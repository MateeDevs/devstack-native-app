package config

import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import constants.ProjectConstants
import org.gradle.api.Project

internal fun Project.configureSingingConfigs(
    module: BaseAppModuleExtension,
) = with(module) {
    signingConfigs {
        named(ProjectConstants.Variant.debug).configure {
            storeFile = file("../../other/keystore/debug.jks")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }

        register(ProjectConstants.Variant.release) {
            storeFile = file("../../other/keystore/release.jks")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }
    }

    buildTypes {
        debug {
            isMinifyEnabled = false
            applicationIdSuffix = ".${ProjectConstants.Variant.debug}"
            signingConfig = signingConfigs.getByName(ProjectConstants.Variant.debug)
        }

        named(ProjectConstants.Variant.alpha) {
            applicationIdSuffix = ".${ProjectConstants.Variant.alpha}"
            signingConfig = signingConfigs.getByName(ProjectConstants.Variant.debug)
        }

        getByName("release") {
            isMinifyEnabled = false
            signingConfig = signingConfigs.getByName(ProjectConstants.Variant.release)
        }
    }
}
