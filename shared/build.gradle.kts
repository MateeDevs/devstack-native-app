import KmmConfig.copyXCFramework
import Project as ProjectConst

@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    id(libs.plugins.android.library.get().pluginId)
    kotlin("multiplatform")
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
    kmm(project, ProjectConst.iosShared)

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
        KmmConfig.getSupportedMobilePlatforms(this@kotlin, project).forEach {
            with(KmmConfig) {
                getByName(it.asMainSourceSetName).dependsOn(iosMain)
            }
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
    copyXCFramework(ProjectConst.iosShared)
}
