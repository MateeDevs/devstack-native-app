@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.android.application.compose)
}

android {
    namespace = "kmp.android"
}

dependencies {
    implementation(project(":shared"))
    implementation(project(":android:shared"))
    implementation(project(":android:login"))
    implementation(project(":android:users"))
    implementation(project(":android:profile"))
    implementation(project(":android:recipes"))
    implementation(project(":android:books"))
    implementation(project(":android:videos"))
}
