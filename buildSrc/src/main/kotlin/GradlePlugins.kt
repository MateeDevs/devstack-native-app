object GradlePlugins {

    private const val gradleBuildTools = "4.1.2"
    private const val safeArgsVersion = "2.2.0-rc01"
    private const val sqlDelightVersion = "1.4.3"

    const val kotlinSerialiation = "org.jetbrains.kotlin:kotlin-serialization:${kotlin_version}"
    const val androidGradle = "com.android.tools.build:gradle:${gradleBuildTools}"
    const val safeArgs = "androidx.navigation:navigation-safe-args-gradle-plugin:${safeArgsVersion}"
    const val sqlDelight = "com.squareup.sqldelight:gradle-plugin:$sqlDelightVersion"
}