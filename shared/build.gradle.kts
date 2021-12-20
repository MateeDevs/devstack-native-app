import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework

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


    val xcf = XCFramework(Project.iosShared)
    listOf(iosX64(), iosArm64(), iosSimulatorArm64())
        .forEach {
            it.binaries.framework {
                baseName = Project.iosShared
                isStatic = false
                xcf.add(this)
            }
        }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(Dependency.Kotlin.Coroutines.common)
                implementation(Dependency.Koin.core)

                implementation(Dependency.Settings.core)
                implementation(Dependency.Settings.coroutines)
                implementation(Dependency.Settings.noArg)


                implementation(Dependency.SqlDelight.runtime)
                implementation(Dependency.SqlDelight.coroutinesExtension)

                implementation(Dependency.Ktor.core)
                implementation(Dependency.Ktor.serialization)
            }
        }

        val androidMain by getting {
            dependencies {
                implementation(Dependency.Ktor.android)
                implementation(Dependency.SqlDelight.androidDriver)
            }
        }

        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependencies {
                implementation(Dependency.Ktor.ios)
                implementation(Dependency.SqlDelight.iosDriver)
            }
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
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


tasks.create("buildXCFramework") {
    dependsOn("assembleDevstackKmpSharedXCFramework")
    copyXCFramework(Project.iosShared)
}


fun copyXCFramework(projectName: String) {
    val buildPathRelease = "build/XCFrameworks/release/$projectName.xcframework"
    val sharedIOSPath = "swiftpackage/$projectName.xcframework"

    delete(sharedIOSPath)
    copy {
        from(buildPathRelease)
        into(sharedIOSPath)
    }
}