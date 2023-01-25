package plugin.config

import Dependency
import org.gradle.kotlin.dsl.dependencies
import plugin.BasePlugin

class AndroidPresentation : BasePlugin({
    android {
        buildFeatures {
            compose = true
        }

        composeOptions {
            kotlinCompilerExtensionVersion = Dependency.Compose.compilerExtensionVersion
        }
    }

    dependencies {

        "implementation"(project.dependencies.platform(Dependency.Kotlin.stdlib))
        "implementation"(Dependency.AndroidX.core)

        "implementation"(Dependency.Compose.ui)
        "implementation"(Dependency.Compose.uiTooling)
        "implementation"(Dependency.Compose.foundation)
        "implementation"(Dependency.Compose.material)
        "implementation"(Dependency.Compose.materialIconsCore)

        "implementation"(Dependency.Compose.Navigation.core)

        "implementation"(Dependency.AndroidX.Paging.runtime)
        "implementation"(Dependency.AndroidX.Paging.compose)

        "implementation"(Dependency.Koin.android)
        "implementation"(Dependency.Koin.compose)
    }
})
