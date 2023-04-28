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
import org.gradle.kotlin.dsl.withType
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension
import org.jetbrains.kotlin.gradle.tasks.KotlinNativeLink

@Suppress("unused")
class KmmLibraryConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            pluginManager {
                apply(libs.plugins.android.library)
                apply(libs.plugins.kotlin.multiplatform)
                apply(libs.plugins.serialization)
                apply(libs.plugins.sqlDelight)
                apply(libs.plugins.ktlint)
                apply(libs.plugins.mokoResources)
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
                            api(libs.mokoResources)
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
                            implementation(libs.koin.android)
                            implementation(libs.sqlDelight.androidDriver)
                            implementation(libs.video.transcoder)
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

            // There is a bug in Xcode 15.3 - archive validation fails if SDKs support a lower minimum OS version than the app 
            // Konan plugin sets minVersion.ios to 12.0 by default, but we have 15.0 in our app
            // This line changes Konan property to 15.0
            tasks.withType<KotlinNativeLink> {
                kotlinOptions.freeCompilerArgs += "-Xoverride-konan-properties=minVersion.ios=15.0"
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
