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
include(":android:app", ":android:shared", ":shared")
include(":android:login")
include(":android:profile")
include(":android:users")
include(":android:recipes")
include(":android:books")
include(":android:videos")
