plugins {
    id("com.android.library")
    kotlin("android")
}

android {
    namespace = "cz.runczech.android.shared"
}

apply<plugin.AndroidLibraryPlugin>()

dependencies {
    implementation(project(Project.shared))
}