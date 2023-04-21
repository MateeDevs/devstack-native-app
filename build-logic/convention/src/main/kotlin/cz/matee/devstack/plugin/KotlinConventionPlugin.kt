package cz.matee.devstack.plugin

import cz.matee.devstack.constants.ProjectConstants
import cz.matee.devstack.extensions.android
import cz.matee.devstack.extensions.apply
import cz.matee.devstack.extensions.implementation
import cz.matee.devstack.extensions.java
import cz.matee.devstack.extensions.libs
import cz.matee.devstack.extensions.pluginManager
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.dependencies
import org.gradle.kotlin.dsl.withType
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

@Suppress("unused")
class KotlinConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            pluginManager {
                apply(libs.plugins.kotlin.android)
            }

            java {
                sourceCompatibility = ProjectConstants.javaVersion
                targetCompatibility = ProjectConstants.javaVersion
            }

            android {
                compileOptions {
                    sourceCompatibility = ProjectConstants.javaVersion
                    targetCompatibility = ProjectConstants.javaVersion
                }
            }

            tasks.withType<KotlinCompile> {
                kotlinOptions {
                    jvmTarget = ProjectConstants.javaVersion.toString()
                    freeCompilerArgs = freeCompilerArgs + listOf(
                        "-Xallow-jvm-ir-dependencies",
                        "-opt-in=kotlin.RequiresOptIn",
                    )
                }
            }

            dependencies {
                implementation(libs.kotlin.stdlib)
                implementation(libs.kotlinx.immutableCollections)
            }
        }
    }
}
