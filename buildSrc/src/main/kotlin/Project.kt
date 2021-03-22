const val TWINE_HOME_FOLDER_ARG = "twineLocalizationFolder"
const val WINDOWS_PROJECT_HOME_FOLDER_ARG = "projectHomeFolder"
const val GITHUB_USER = "githubUser"
const val GITHUB_PAT = "githubPAT"

const val kotlinVersion = "1.4.31"

object Project {
    const val shared = ":shared"
    const val iosShared = "DevstackKmpShared"

    object Android {
        private const val root = ":android"
        const val shared = "$root:shared"
        const val login = "$root:login"
        const val profile = "$root:profile"
        const val users = "$root:users"
        const val recipes = "$root:recipes"
    }
}

object GradlePlugins {

    private const val gradleBuildTools = "7.0.0-alpha10"
    private const val safeArgsVersion = "2.2.0-rc01"
    private const val sqlDelightVersion = Dependency.SqlDelight.version

    const val androidGradle = "com.android.tools.build:gradle:${gradleBuildTools}"
    const val kotlinSerialization = "org.jetbrains.kotlin:kotlin-serialization:${kotlinVersion}"
    const val safeArgs = "androidx.navigation:navigation-safe-args-gradle-plugin:${safeArgsVersion}"
    const val sqlDelight = "com.squareup.sqldelight:gradle-plugin:$sqlDelightVersion"
}