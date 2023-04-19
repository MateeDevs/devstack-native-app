import extensions.getStringProperty
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType
import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework
import Project as ProjectConst

@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.kotlin.multiplatform)
    alias(libs.plugins.serialization)
    alias(libs.plugins.sqlDelight)
}

// https://youtrack.jetbrains.com/issue/KT-43944
android {
    configurations {
        create("testApi")
        create("testDebugApi")
        create("testReleaseApi")
    }
}

kotlin {
    android()
    with(project) {
        val xcf = XCFramework(ProjectConst.iosShared)
        listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
            it.binaries.framework {
                val currentNativeBuildTypeString = getStringProperty(project, "XCODE_CONFIGURATION", "release").lowercase()
                val currentNativeBuildType = if (currentNativeBuildTypeString.contains("debug")) {
                    NativeBuildType.DEBUG
                } else {
                    NativeBuildType.RELEASE
                }
                if (this.buildType == currentNativeBuildType) {
                    baseName = ProjectConst.iosShared
                    isStatic = false
                    xcf.add(this)
                }
            }
        }
    }

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
        listOf(iosX64(), iosArm64(), iosSimulatorArm64()).forEach {
            getByName("${it.name}Main").dependsOn(iosMain)
        }
    }
}

android {
    compileSdk = libs.versions.sdk.compile.get().toInt()
    defaultConfig {
        minSdk = libs.versions.sdk.min.get().toInt()
        targetSdk = libs.versions.sdk.target.get().toInt()
    }
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    namespace = "cz.matee.devstack.kmp.shared"
}

sqldelight {
    database("Database") {
        packageName = "cz.matee.devstack.kmp"
    }
}

tasks.register("buildXCFramework") {
    dependsOn("assemble${ProjectConst.iosShared}XCFramework")
}

tasks.register("copyXCFramework") {
    val currentNativeBuildTypeString = getStringProperty(project, "XCODE_CONFIGURATION", "release").lowercase()
    val currentNativeBuildType = if (currentNativeBuildTypeString.contains("debug")) {
        NativeBuildType.DEBUG
    } else {
        NativeBuildType.RELEASE
    }
    val buildPathRelease =
        "build/XCFrameworks/${currentNativeBuildType.name.lowercase()}/${ProjectConst.iosShared}.xcframework"
    val iosXCBinaryPath = "../ios/DomainLayer/${ProjectConst.iosShared}.xcframework"

    project.delete(iosXCBinaryPath)
    project.copy {
        from(buildPathRelease)
        into(iosXCBinaryPath)
    }
}
