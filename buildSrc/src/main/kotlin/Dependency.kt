import org.jetbrains.kotlin.gradle.plugin.KotlinDependencyHandler

@Suppress("SpellCheckingInspection")
object Dependency {

    object Kotlin {
        const val stdlib = "org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion"

        object Coroutines {
            private const val version = "1.4.2"

            const val common = "org.jetbrains.kotlinx:kotlinx-coroutines-core:$version"
            const val android = "org.jetbrains.kotlinx:kotlinx-coroutines-android:$version"
        }
    }

    object Koin {
        private const val version = "3.0.1-alpha-3"

        const val core = "org.koin:koin-core:$version"
        const val android = "org.koin:koin-android:$version"
        const val compose = "org.koin:koin-androidx-compose:$version"
    }

    object AndroidX {
        const val core = "androidx.core:core-ktx:1.3.2"
        const val appCompat = "androidx.appcompat:appcompat:1.2.0"

        const val material = "com.google.android.material:material:1.3.0"
    }

    object Compose {
        const val version = "1.0.0-alpha12"
        private const val activityVersion = "1.3.0-alpha02"
        private const val navigationVersion = "1.0.0-alpha07"

        const val ui = "androidx.compose.ui:ui:$version"
        const val uiTooling = "androidx.compose.ui:ui-tooling:$version"
        const val foundation = "androidx.compose.foundation:foundation:$version"

        const val activity = "androidx.activity:activity-compose:$activityVersion"
        const val navigation = "androidx.navigation:navigation-compose:$navigationVersion"

        const val material = "androidx.compose.material:material:$version"
        const val materialIconsCore = "androidx.compose.material:material-icons-core:$version"

        const val uiTest = "androidx.compose.ui:ui-test-junit4:$version"

        object Accompanist {
            private const val version = "0.5.1"
            const val insets = "dev.chrisbanes.accompanist:accompanist-insets:$version"
        }
    }


    object Ktor {
        private const val version = "1.5.1"

        const val core = "io.ktor:ktor-client-core:$version"
        const val android = "io.ktor:ktor-client-android:$version"
        const val ios = "io.ktor:ktor-client-ios:$version"

        // Features https://ktor.io/docs/http-client-features.html
        const val serialization = "io.ktor:ktor-client-serialization:$version"


        fun KotlinDependencyHandler.commonImplementation() {
            implementation(core)
            implementation(serialization)
        }
    }

    object Matee {
        object Core {
            private const val version = "1.0.0-rc4"
            const val core = "cz.matee.and:core:$version"
        }
    }

    object Settings {
        private const val version = "0.7.2"

        const val core = "com.russhwolf:multiplatform-settings:$version"
        const val noArg = "com.russhwolf:multiplatform-settings-no-arg:$version"
        const val coroutines = "com.russhwolf:multiplatform-settings-coroutines:$version"
    }

    object SqlDelight {
        private const val sqlDelightVersion = "1.4.4"

        val runtime = "com.squareup.sqldelight:runtime:$sqlDelightVersion"
        val coroutinesExtension = "com.squareup.sqldelight:coroutines-extensions:$sqlDelightVersion"

        val androidDriver = "com.squareup.sqldelight:android-driver:$sqlDelightVersion"
        val iosDriver = "com.squareup.sqldelight:native-driver:$sqlDelightVersion"
    }
}
//
//    val coroutinesExcludeNative: ExternalModuleDependency.() -> Unit = {
//        exclude(group = "org.jetbrains.kotlinx", module = "kotlinx-coroutines-core-native")
//    }
//}
