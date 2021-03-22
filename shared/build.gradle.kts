import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget

plugins {
    id("com.android.library")
    kotlin("multiplatform")
    kotlin("plugin.serialization") version kotlinVersion
    id("com.squareup.sqldelight")
    id("com.chromaticnoise.multiplatform-swiftpackage") version "2.0.3"
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

    ios {
        binaries {
            framework {
                baseName = Project.iosShared
            }
        }
    }

    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation(Dependency.Kotlin.Coroutines.common) {
                    version {
                        strictly(Dependency.Kotlin.Coroutines.version)
                    }
                }
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

sqldelight {
    database("Database") {
        packageName = "cz.matee.devstack.kmp"
    }
}

multiplatformSwiftPackage {
    swiftToolsVersion("5.3")
    targetPlatforms {
        iOS { v("11") } // device + simulator
//        targets("iosX64") { v("11") } // simulator
//        targets("iosArm64") { v("11") }
    }
    packageName(Project.iosShared)

}
