import KmmConfig.copyXCFramework
import Project as ProjectConst

plugins {
    id("com.android.library")
    kotlin("multiplatform")
    kotlin("plugin.serialization") version kotlinVersion
    id("com.squareup.sqldelight")
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
                implementation(Dependency.Kotlin.Coroutines.common)
                implementation(Dependency.Kotlin.AtomicFU.core)
                implementation(Dependency.Kotlin.DateTime.core)

                implementation(Dependency.Koin.core)

                implementation(Dependency.Settings.core)
                implementation(Dependency.Settings.coroutines)
                implementation(Dependency.Settings.noArg)


                implementation(Dependency.SqlDelight.runtime)
                implementation(Dependency.SqlDelight.coroutinesExtension)

                implementation(Dependency.Ktor.core)
                implementation(Dependency.Ktor.serialization)
                implementation(Dependency.Ktor.contentNegotiation)
                implementation(Dependency.Ktor.logging)

                implementation(Dependency.Kermit.core)
            }
        }

        val androidMain by getting {
            dependsOn(commonMain)
            dependencies {
                implementation(Dependency.Ktor.android)
                implementation(Dependency.SqlDelight.androidDriver)
            }
        }

        val iosMain by creating {
            dependsOn(commonMain)
            dependencies {
                implementation(Dependency.SqlDelight.iosDriver)
                implementation(Dependency.Ktor.ios)
            }
        }
        KmmConfig.getSupportedMobilePlatforms(this@kotlin, project).forEach {
            with(KmmConfig) {
                getByName(it.asMainSourceSetName).dependsOn(iosMain)
            }
        }

        // New memory model - https://github.com/JetBrains/kotlin/blob/master/kotlin-native/NEW_MM.md
        targets.withType(org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget::class.java) {
            binaries.all {
                freeCompilerArgs = freeCompilerArgs + "-Xruntime-logs=gc=info"
                binaryOptions["memoryModel"] = "experimental"
                binaryOptions["freezing"] = "disabled"
            }
        }
    }
}



android {
    compileSdkVersion(Application.Sdk.compile)
    defaultConfig {
        minSdkVersion(Application.Sdk.min)
        targetSdkVersion(Application.Sdk.target)
    }
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
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