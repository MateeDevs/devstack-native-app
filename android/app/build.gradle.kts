@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.android.application.compose)
}

android {
    namespace = "kmp.android"
}

dependencies {
    implementation(project(":shared:core"))
    implementation(project(":android:shared"))
    implementation(project(":android:sample"))
    implementation(project(":android:samplesharedviewmodel"))
    implementation(project(":android:samplecomposemultiplatform"))
}
