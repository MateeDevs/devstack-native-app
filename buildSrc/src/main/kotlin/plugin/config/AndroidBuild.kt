package plugin.config

import Application
import Dependency
import org.gradle.api.plugins.ExtensionAware
import org.gradle.kotlin.dsl.dependencies
import org.gradle.kotlin.dsl.extra
import plugin.BasePlugin

class AndroidBuild : BasePlugin({
    android {
        compileSdkVersion(Application.Sdk.compile)
        defaultConfig {
            minSdk = Application.Sdk.min
            targetSdk = Application.Sdk.target
            testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        }

        sourceSets {
            getByName("test").java.srcDirs("src/test/kotlin")
            getByName("androidTest").java.srcDirs("src/androidTest/kotlin")
            getByName("release").java.srcDirs("src/release/kotlin")
            getByName("main").res.srcDirs(
                "src/main/res",
                "src/main/res/drawable",
                "src/main/res/drawableFlags"
            )
        }

        buildTypes {
            getByName("debug") {
                splits.abi { isEnable = false }
                splits.density { isEnable = false }
                aaptOptions.cruncherEnabled = false
                (this as ExtensionAware).extra["alwaysUpdateBuildId"] = false
            }

            create("uat") {
                initWith(getByName("release"))
                matchingFallbacks.addAll(listOf("debug", "release"))
            }

            getByName("release") {

            }
        }

        lint(project) {
            disable += "InvalidPackage"
            error += "HardcodedText"
            abortOnError = false
        }
        dependencies {
            "coreLibraryDesugaring"(Dependency.AndroidTools.desugarJdkLibs)
        }
    }
})
