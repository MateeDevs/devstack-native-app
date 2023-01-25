package plugin.config

import Dependency
import org.gradle.kotlin.dsl.dependencies
import org.gradle.kotlin.dsl.withType
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import plugin.BasePlugin

class Coroutines : BasePlugin({
    tasks.withType<KotlinCompile> {
        kotlinOptions {
            @Suppress("SuspiciousCollectionReassignment")
            freeCompilerArgs += listOf(
                "-Xopt-in=kotlinx.coroutines.ExperimentalCoroutinesApi",
                "-Xopt-in=kotlinx.coroutines.FlowPreview"
            )
        }
    }

    dependencies {
        "implementation"(Dependency.Kotlin.Coroutines.common)
        android {
            "implementation"(Dependency.Kotlin.Coroutines.android)
        }
    }
})
