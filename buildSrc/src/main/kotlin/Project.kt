const val TWINE_HOME_FOLDER_ARG = "twineLocalizationFolder"
const val WINDOWS_PROJECT_HOME_FOLDER_ARG = "projectHomeFolder"

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