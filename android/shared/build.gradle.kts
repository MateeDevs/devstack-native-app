@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.android.library.compose)
}

android {
    namespace = "kmp.android.shared"
}

dependencies {

    implementation(project(":shared:core"))
    implementation(libs.googlePlayServices.location)
}
