const val kotlinVersion = "1.4.30"

object Project {
    const val shared = ":shared"
}

object GradlePlugins {

    private const val gradleBuildTools = "7.0.0-alpha06"
    private const val safeArgsVersion = "2.2.0-rc01"
    private const val sqlDelightVersion = "1.4.3"

    const val androidGradle = "com.android.tools.build:gradle:${gradleBuildTools}"
    const val kotlinSerialiation = "org.jetbrains.kotlin:kotlin-serialization:${kotlinVersion}"
    const val safeArgs = "androidx.navigation:navigation-safe-args-gradle-plugin:${safeArgsVersion}"
    const val sqlDelight = "com.squareup.sqldelight:gradle-plugin:$sqlDelightVersion"
}