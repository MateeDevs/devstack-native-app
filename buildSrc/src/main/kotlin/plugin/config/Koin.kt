package plugin.config

import Dependency
import org.gradle.kotlin.dsl.dependencies
import plugin.BasePlugin

class Koin : BasePlugin({

    dependencies {
        "implementation"(Dependency.Koin.core)
        "implementation"(Dependency.Koin.android)
        "implementation"(Dependency.Koin.compose)
    }
})
