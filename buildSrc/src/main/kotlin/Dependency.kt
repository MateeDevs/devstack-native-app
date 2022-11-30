
@Suppress("SpellCheckingInspection")
object Dependency {

    object Kotlin {
        const val stdlib = "org.jetbrains.kotlin:kotlin-stdlib:$kotlinVersion"

        object Coroutines {
            const val version = "1.6.0"

            const val common = "org.jetbrains.kotlinx:kotlinx-coroutines-core:$version"
            const val android = "org.jetbrains.kotlinx:kotlinx-coroutines-android:$version"
        }

        object DateTime {
            const val version = "0.4.0"
            const val core = "org.jetbrains.kotlinx:kotlinx-datetime:$version"
        }

        object AtomicFU {
            private const val version = "0.18.3"
            const val core = "org.jetbrains.kotlinx:atomicfu:$version"
        }
    }

    object Koin {
        private const val version = "3.1.4"

        const val core = "io.insert-koin:koin-core:$version"
        const val android = "io.insert-koin:koin-android:$version"
        const val compose = "io.insert-koin:koin-androidx-compose:$version"
    }

    object AndroidX {
        const val core = "androidx.core:core-ktx:1.9.0"
        const val testRunner = "androidx.test.runner.AndroidJUnitRunner"

        object Material {
            private const val version = "1.4.0"
            const val core = "com.google.android.material:material:$version"
        }

        object Lifecycle {
            private const val version = "2.4.0"
            const val runtime = "androidx.lifecycle:lifecycle-runtime-ktx:$version"
            const val core = "androidx.lifecycle:lifecycle-common-java8:$version"
        }

        object Paging {
            private const val version = "3.1.0"
            private const val composeVersion = "1.0.0-alpha14"

            const val runtime = "androidx.paging:paging-runtime:$version"
            const val compose = "androidx.paging:paging-compose:$composeVersion"
        }
    }

    object Compose {
        const val version = "1.3.0-rc01"
        const val compilerExtensionVersion = version

        const val ui = "androidx.compose.ui:ui:$version"
        const val uiTooling = "androidx.compose.ui:ui-tooling:$version"
        const val foundation = "androidx.compose.foundation:foundation:$version"

        const val material = "androidx.compose.material:material:$version"
        const val materialIconsCore = "androidx.compose.material:material-icons-core:$version"
        const val materialIconsExtended =
            "androidx.compose.material:material-icons-extended:$version"

        const val uiTest = "androidx.compose.ui:ui-test-junit4:$version"

        object Activity {
            private const val version = "1.4.0"
            const val core = "androidx.activity:activity-compose:$version"
        }

        object Navigation {
            private const val version = "2.4.0-beta02"
            const val core = "androidx.navigation:navigation-compose:$version"
        }

        object ConstraintLayout {
            private const val version = "1.0.0-rc02"
            const val core = "androidx.constraintlayout:constraintlayout-compose:$version"
        }

        // https://google.github.io/accompanist/
        object Accompanist {
            private const val version = "0.20.3"

            const val insets = "com.google.accompanist:accompanist-insets:$version"
            const val pager = "com.google.accompanist:accompanist-pager:$version"
            const val pagerIndiactors =
                "com.google.accompanist:accompanist-pager-indicators:$version"
            const val coil = "com.google.accompanist:accompanist-coil:$version"
        }
    }


    object Ktor {
        private const val version = "2.1.2"

        const val core = "io.ktor:ktor-client-core:$version"
        const val android = "io.ktor:ktor-client-android:$version"
        const val ios = "io.ktor:ktor-client-ios:$version"

        // Features https://ktor.io/docs/http-client-features.html
        const val serialization = "io.ktor:ktor-serialization-kotlinx-json:$version"
        const val contentNegotiation = "io.ktor:ktor-client-content-negotiation:$version"
        const val logging = "io.ktor:ktor-client-logging:$version"
    }

    object Kermit {
        private const val version = "1.1.2"
        const val core = "co.touchlab:kermit:$version"
    }

    object Matee {
        object Core {
            private const val version = "1.0.0-rc8"

            //            const val core = "cz.matee.and:core-compose:$version"
//            const val compose = "cz.matee.and:core-compose:$version"
        }
    }

    // https://github.com/russhwolf/multiplatform-settings
    object Settings {
        private const val version = "0.8.1"

        const val core = "com.russhwolf:multiplatform-settings:$version"
        const val noArg = "com.russhwolf:multiplatform-settings-no-arg:$version"
        const val coroutines = "com.russhwolf:multiplatform-settings-coroutines:$version"
    }

    // https://github.com/cashapp/sqldelight
    object SqlDelight {
        const val version = "1.5.3"

        const val runtime = "com.squareup.sqldelight:runtime:$version"
        const val coroutinesExtension = "com.squareup.sqldelight:coroutines-extensions:$version"

        const val androidDriver = "com.squareup.sqldelight:android-driver:$version"
        const val iosDriver = "com.squareup.sqldelight:native-driver:$version"
    }

    object Play {
        private const val version = "18.0.0"

        const val location = "com.google.android.gms:play-services-location:$version"
    }
}
