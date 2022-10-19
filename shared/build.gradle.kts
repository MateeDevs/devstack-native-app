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
    KmmConfig.getSupportedPlatforms(this, project).forEach {
        it.binaries.framework {
            if (this.buildType == KmmConfig.getCurrentNativeBuildType(project)) {
                baseName = Project.iosShared
                isStatic = false
                xcf.add(this)
            }
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

        val iosX64Main by getting
        val iosArm64Main by getting
        val iosSimulatorArm64Main by getting
        val iosMain by creating {
            dependsOn(commonMain)
            dependencies {
                implementation(Dependency.Ktor.ios)
                implementation(Dependency.SqlDelight.iosDriver)
            }
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            iosSimulatorArm64Main.dependsOn(this)
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
    dependsOn("assemble${Project.iosShared}XCFramework")
}

tasks.register("copyXCFramework") {
    copyXCFramework(Project.iosShared)
}


fun copyXCFramework(projectName: String) {
    val buildPathRelease = "build/XCFrameworks/release/$projectName.xcframework"
    val sharedSwiftpackagePath = "swiftpackage/$projectName.xcframework"
    val iosXCBinaryPath = "../ios/DomainLayer/$projectName.xcframework"

    delete(sharedSwiftpackagePath)
    delete(iosXCBinaryPath)
    copy {
        from(buildPathRelease)
        into(sharedSwiftpackagePath)
    }
    copy {
        from(buildPathRelease)
        into(iosXCBinaryPath)
    }
}