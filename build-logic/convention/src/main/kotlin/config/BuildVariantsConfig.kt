package config

import com.android.build.api.dsl.BuildType
import com.android.build.api.dsl.CommonExtension
import constants.ProjectConstants
import org.gradle.api.plugins.ExtensionAware
import org.gradle.kotlin.dsl.extra

internal fun <T : BuildType> CommonExtension<*, T, *, *, *>.configureBuildVariants() {
    buildTypes {
        debug {
            splits.abi.isEnable = false
            splits.density.isEnable = false
            (this as ExtensionAware).extra["alwaysUpdateBuildId"] = false
        }
        create(ProjectConstants.Variant.alpha) {
            initWith(getByName("release"))
        }
        release {
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}
