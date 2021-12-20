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


    val xcf = XCFramework("DevstackKmpShared")
    iosX64 {
        binaries.framework {
            baseName = "DevstackKmpShared"
            isStatic = false
            xcf.add(this)
        }
    }
    iosArm64 {
        binaries.framework {
            baseName = "DevstackKmpShared"
            isStatic = false
            xcf.add(this)
        }
    }
    iosSimulatorArm64 {
        binaries.framework {
            baseName = "DevstackKmpShared"
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
    copyXCFramework()
}


fun copyXCFramework() {
    val buildPathRelease = "build/XCFrameworks/release/DevstackKmpShared.xcframework"
    val sharediOSPath = "swiftpackage/DevstackKmpShared.xcframework"

    delete(sharediOSPath)
    copy {
        from(buildPathRelease)
        into(sharediOSPath)
    }
}