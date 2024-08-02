pluginManagement {
    includeBuild("build-logic")
    repositories {
        gradlePluginPortal()
        mavenCentral()
        google()
    }
}

dependencyResolutionManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
        google()
        maven("https://plugins.gradle.org/m2/")
    }
}

rootProject.buildFileName = "build.gradle.kts"
rootProject.name = "devstack-native-app"

include(":android:app")
include(":android:shared")
include(":android:sample")
include(":android:samplesharedviewmodel")
include(":android:samplecomposemultiplatform")

include(":shared:core")
include(":shared:base")
include(":shared:sample")
include(":shared:samplesharedviewmodel")
include(":shared:sampleComposeMultiplatform")
