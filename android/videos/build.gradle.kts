@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.android.library.compose)
}

android {
    namespace = "cz.matee.devstack.kmp.android.videos"
}

dependencies {
    implementation(project(":shared"))
    implementation(project(":android:shared"))
    implementation(libs.exoPlayer)
    implementation(libs.exoPlayer.ui)
    implementation(libs.exoPlayer.session)
}
