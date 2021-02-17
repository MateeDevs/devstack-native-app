rootProject.buildFileName = "build.gradle.kts"
rootProject.name = "devstack-kmp-app"
include(":android:app", ":android:shared", ":shared")
include(":android:login")
include(":android:profile")
include(":android:users")
include(":android:recipes")
