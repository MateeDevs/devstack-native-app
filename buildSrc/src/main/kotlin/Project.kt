const val kotlinVersion = "1.4.30"

const val TWINE_HOME_FOLDER_ARG = "twineLocalizationFolder"
const val WINDOWS_PROJECT_HOME_FOLDER_ARG = "projectHomeFolder"
const val GITHUB_USER = "githubUser"
const val GITHUB_PAT = "githubPAT"

object Project {
    const val shared = ":shared"

    object Android {
        private const val root = ":android"
        const val shared = "$root:shared"
        const val login = "$root:login"
    }
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