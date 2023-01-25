plugins {
    id("com.android.library")
    kotlin("android")
}
android {
    namespace = "cz.runczech.android.feature.livetracking"
}

apply<plugin.AndroidLibraryPlugin>()

dependencies {
    implementation(project(Project.shared))
    implementation(project(Project.Android.shared))
}