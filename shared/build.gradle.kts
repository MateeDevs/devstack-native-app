import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

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

    val iOSTarget: (String, KotlinNativeTarget.() -> Unit) -> KotlinNativeTarget =
        if (System.getenv("SDK_NAME")?.startsWith("iphoneos") == true)
            ::iosArm64
        else
            ::iosX64

    iOSTarget("ios") {
        binaries {
            framework {
                baseName = Project.shared
            }
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(Dependency.Koin.core)

                implementation(Dependency.Settings.core)
                implementation(Dependency.Settings.coroutines)
                implementation(Dependency.Settings.noArg)

                implementation(Dependency.SqlDelight.runtime)
                implementation(Dependency.SqlDelight.coroutinesExtension)

                with(Dependency.Ktor) { commonImplementation() }
            }
        }

        val androidMain by getting {
            dependencies {
                implementation(Dependency.Ktor.android)
                implementation(Dependency.SqlDelight.androidDriver)
            }
        }

        val iosMain by getting {
            dependencies {
                implementation(Dependency.Ktor.ios)
                implementation(Dependency.SqlDelight.iosDriver)
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

val packForXcode by tasks.creating(Sync::class) {
    group = "build"
    val mode = System.getenv("CONFIGURATION") ?: "DEBUG"
    val framework = kotlin.targets.getByName<KotlinNativeTarget>("ios").binaries.getFramework(mode)
    inputs.property("mode", mode)
    dependsOn(framework.linkTask)
    val targetDir = File(buildDir, "xcode-frameworks")
    from({ framework.outputDirectory })
    into(targetDir)
}
tasks.getByName("build").dependsOn(packForXcode)

sqldelight {
    database("Database") {
        packageName = "cz.matee.devstack.kmp"
    }
}