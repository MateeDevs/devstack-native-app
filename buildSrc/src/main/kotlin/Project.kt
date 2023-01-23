const val TWINE_HOME_FOLDER_ARG = "twineLocalizationFolder"
const val WINDOWS_PROJECT_HOME_FOLDER_ARG = "projectHomeFolder"

const val kotlinVersion = "1.8.0"

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
        const val books = "$root:books"
    }
}

object GradlePlugins {

    private const val safeArgsVersion = "2.3.5"
    private const val sqlDelightVersion = Dependency.SqlDelight.version

    const val kotlinSerialization = "org.jetbrains.kotlin:kotlin-serialization:1.3.1"
    const val safeArgs = "androidx.navigation:navigation-safe-args-gradle-plugin:${safeArgsVersion}"
    const val sqlDelight = "com.squareup.sqldelight:gradle-plugin:$sqlDelightVersion"
}