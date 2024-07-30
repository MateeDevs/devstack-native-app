package constants

import org.gradle.api.JavaVersion

object ProjectConstants {
    const val iosShared = "KMPShared"
    val javaVersion = JavaVersion.VERSION_17

    object Android {
        private const val root = ":android"
        const val shared = "$root:shared"
        const val login = "$root:login"
        const val profile = "$root:profile"
        const val users = "$root:users"
        const val recipes = "$root:recipes"
        const val books = "$root:books"
    }

    object Variant {
        const val debug = "debug"
        const val alpha = "alpha"
        const val release = "release"
    }
}
