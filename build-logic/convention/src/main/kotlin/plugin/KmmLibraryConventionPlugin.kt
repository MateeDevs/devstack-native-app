package plugin

import com.android.build.api.dsl.LibraryExtension
import config.KmmConfig
import config.KmmConfig.copyXCFramework
import config.configureBuildVariants
import config.configureKotlinAndroid
import config.configureTests
import config.kmm
import constants.ProjectConstants
import extensions.apply
import extensions.libs
import extensions.pluginManager
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.configure
import org.gradle.kotlin.dsl.creating
import org.gradle.kotlin.dsl.getValue
import org.gradle.kotlin.dsl.getting
import org.gradle.kotlin.dsl.invoke
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension

@Suppress("unused")
class KmmLibraryConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            pluginManager {
                apply(libs.plugins.android.library)
                apply(libs.plugins.android.library)
                apply(libs.plugins.kotlin.multiplatform)
                apply(libs.plugins.serialization)
                apply(libs.plugins.sqlDelight)
                apply(libs.plugins.ktlint)
            }

            extensions.configure<LibraryExtension> {
                compileSdk = libs.versions.sdk.compile.get().toInt()

                defaultConfig {
                    minSdk = libs.versions.sdk.min.get().toInt()
                }

                compileOptions {
                    sourceCompatibility = ProjectConstants.javaVersion
                    targetCompatibility = ProjectConstants.javaVersion
                }
                configureBuildVariants()

                buildFeatures {
                    buildConfig = true
                }
            }

            extensions.configure<KotlinMultiplatformExtension> {
                android()
                kmm(
                    project = project,
                    nativeName = ProjectConstants.iosShared,
                )

                sourceSets {
                    val commonMain by getting {
                        dependencies {
                            implementation(libs.coroutines.core)
                            implementation(libs.atomicFu)
                            implementation(libs.dateTime)
                            implementation(libs.koin.core)
                            implementation(libs.bundles.settings)
                            implementation(libs.bundles.sqlDelight.common)
                            implementation(libs.bundles.ktor.common)
                            implementation(libs.kermit)
                        }
                    }

                    val androidMain by getting {
                        dependsOn(commonMain)
                        dependencies {
                            implementation(libs.ktor.android)
                            implementation(libs.sqlDelight.androidDriver)
                        }
                    }

                    val iosMain by creating {
                        dependsOn(commonMain)
                        dependencies {
                            implementation(libs.sqlDelight.iosDriver)
                            implementation(libs.ktor.ios)
                        }
                    }
                    KmmConfig.getSupportedMobilePlatforms(this@configure, project).forEach {
                        with(KmmConfig) {
                            getByName(it.asMainSourceSetName).dependsOn(iosMain)
                        }
                    }
                }
            }

            extensions.configure<LibraryExtension> {
                configureKotlinAndroid(this)
                configureTests()
            }

            tasks.register("buildXCFramework") {
                dependsOn("assemble${ProjectConstants.iosShared}XCFramework")
            }

            tasks.register("copyXCFramework") {
                copyXCFramework(ProjectConstants.iosShared)
            }
        }
    }
}
