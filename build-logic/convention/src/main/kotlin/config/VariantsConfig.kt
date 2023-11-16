package config

import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import constants.Application

internal fun BaseAppModuleExtension.configureApplicationVariants() {
    applicationVariants.all {
        if (buildType.name != "release") {
            resValue("string", "app_name", "[${buildType.name.uppercase()}]${Application.appName}")
        } else {
            resValue("string", "app_name", Application.appName)
        }
    }
    applicationVariants.all {
        if (buildType.name != "release") {
            resValue(
                "string",
                "app_name",
                "[${buildType.name.uppercase()}] ${Application.appName}",
            )
        } else {
            resValue("string", "app_name", Application.appName)
        }
    }

    applicationVariants.firstOrNull()?.run {
        println("VersionName: $versionName | VersionCode: $versionCode")
    }
}
