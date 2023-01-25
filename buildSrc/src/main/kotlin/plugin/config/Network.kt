package plugin.config

import Dependency
import org.gradle.kotlin.dsl.dependencies
import plugin.BasePlugin

class KtorClient : BasePlugin({
    dependencies {
        "implementation"(Dependency.Ktor.core)
        "implementation"(Dependency.Ktor.serialization)
    }
})
