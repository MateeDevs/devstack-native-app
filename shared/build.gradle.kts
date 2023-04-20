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
    alias(libs.plugins.ktlint)
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

    // Native platforms the app will support
    val supportedNativePlatforms = listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64(),
        // tvosX64(),
        // tvosArm64(),
        // tvosSimulatorArm64(),
    )
    // Add supported native platforms to XCFramework
    with(project) {
        val xcf = XCFramework(ProjectConst.iosShared)
        supportedNativePlatforms.forEach { target ->
            target.binaries.framework {
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
        // Register source sets for supported native platforms
        supportedNativePlatforms.forEach {
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

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

sqldelight {
    database("Database") {
        packageName = "cz.matee.devstack.kmp"
    }
}

val currentNativeBuildType: NativeBuildType
    get() {
        val currentNativeBuildTypeString =
            getStringProperty(project, "XCODE_CONFIGURATION", "release").lowercase()
        return if (currentNativeBuildTypeString.contains("debug")) {
            NativeBuildType.DEBUG
        } else {
            NativeBuildType.RELEASE
        }
    }

tasks.register("buildXCFramework") {
    dependsOn("assemble${ProjectConst.iosShared}XCFramework")
}

tasks.register("copyXCFramework") {
    val buildPathRelease =
        "build/XCFrameworks/${currentNativeBuildType.name.lowercase()}/${ProjectConst.iosShared}.xcframework"
    val iosXCBinaryPath = "../ios/DomainLayer/${ProjectConst.iosShared}.xcframework"

    project.delete(iosXCBinaryPath)
    project.copy {
        from(buildPathRelease)
        into(iosXCBinaryPath)
    }
}

ktlint {
    filter {
        exclude { entry ->
            entry.file.toString().contains("generated")
        }
    }
}
