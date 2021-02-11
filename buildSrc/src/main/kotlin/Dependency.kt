import org.gradle.api.artifacts.ExternalModuleDependency
import org.gradle.kotlin.dsl.exclude

const val kotlin_version = "1.4.21"

@Suppress("SpellCheckingInspection")
object Dependency {

    object AndroidTools {
        private const val version = "1.0.9"
        const val desugarJdkLibs = "com.android.tools:desugar_jdk_libs:$version"
    }

    const val archUnit = "com.tngtech.archunit:archunit-junit4:0.14.1"

    object AndroidX {
        const val activity = "androidx.activity:activity-ktx:1.1.0"
        const val appCompat = "androidx.appcompat:appcompat:1.1.0"
        const val constraintLayout = "androidx.constraintlayout:constraintlayout:2.0.0-beta7"
        const val core = "androidx.core:core-ktx:1.3.0"
        const val fragment = "androidx.fragment:fragment-ktx:1.2.4"

        object Lifecycle {
            private const val version = "2.2.0"
            const val runtime = "androidx.lifecycle:lifecycle-runtime-ktx:$version"
            const val viewModel = "androidx.lifecycle:lifecycle-viewmodel-ktx:$version"
            const val extensions = "androidx.lifecycle:lifecycle-extensions:$version"
            const val compiler = "androidx.lifecycle:lifecycle-compiler:$version"
        }

        const val material = "com.google.android.material:material:1.1.0"

        object Navigation {
            private const val version = "2.2.2"
            const val fragment = "androidx.navigation:navigation-fragment-ktx:$version"
            const val ui = "androidx.navigation:navigation-ui-ktx:$version"
        }
    }

    object Coroutines {
        private const val version = "1.3.9-native-mt"
        const val common = "org.jetbrains.kotlinx:kotlinx-coroutines-core:${version}"
        const val android = "org.jetbrains.kotlinx:kotlinx-coroutines-android:$version"
        const val test = "org.jetbrains.kotlinx:kotlinx-coroutines-test:$version"
    }

    object JUnit {
        private const val version = "5.6.2"
        const val runtime = "junit:junit:4.12"
        const val vintage = "org.junit.vintage:junit-vintage-engine:$version"
        const val jupiter = "org.junit.jupiter:junit-jupiter:$version"
    }

    object Koin {
        private const val version = "2.1.6"
        const val android = "org.koin:koin-android:$version"
        const val androidViewModel = "org.koin:koin-androidx-viewmodel:$version"
        const val scope = "org.koin:koin-androidx-scope: $version"
        const val test = "org.koin:koin-test:$version"

        // 3.0.1-alpha-2 - mp alpha
        const val core = "org.koin:koin-core:3.0.1-alpha-2"
    }

    object Detekt {
        private const val version = "1.10.0"
        const val formatting = "io.gitlab.arturbosch.detekt:detekt-formatting:$version"
    }

    object KotestAssertions {
        private const val version = "4.0.6"
        const val core = "io.kotest:kotest-assertions-core-jvm:$version"
        const val jvm = "io.kotest:kotest-assertions-jvm:$version"
        const val runner = "io.kotest:kotest-runner-junit5-jvm:$version"
        const val property = "io.kotest:kotest-property-jvm:$version"
    }

    object Mockk {
        private const val version = "1.10.0"
        const val android = "io.mockk:mockk-android:$version"
        const val kotlin = "io.mockk:mockk:$version"
    }

    object Moshi {
        private const val version = "1.9.2"
        const val adapters = "com.squareup.moshi:moshi-adapters:$version"
        const val kotlin = "com.squareup.moshi:moshi-kotlin:$version"
    }

    object OkHttp {
        private const val version = "3.14.9"
        const val core = "com.squareup.okhttp3:okhttp:$version"
        const val logger = "com.squareup.okhttp3:logging-interceptor:$version"
    }

    object Retrofit {
        private const val version = "2.9.0"
        const val core = "com.squareup.retrofit2:converter-moshi:$version"
        const val mock = "com.squareup.retrofit2:retrofit-mock:$version"
    }

    object Room {
        private const val version = "2.2.5"
        const val runtime = "androidx.room:room-ktx:$version"
        const val test = "androidx.room:room-testing:$version"
        const val compiler = "androidx.room:room-compiler:$version"
    }

    object Timber {
        const val timber = "com.jakewharton.timber:timber:4.7.1"
        const val timberKtx = "cz.eman.logger:timber-ktx:0.2.0"
    }

    object ThreeTen {
        const val blackport = "org.threeten:threetenbp:1.4.4"
    }

    object Flipper {
        private const val version = "0.49.0"
        const val flipper = "com.facebook.flipper:flipper:$version"
        const val network = "com.facebook.flipper:flipper-network-plugin:$version"
        const val soloader = "com.facebook.soloader:soloader:0.5.1"
    }

    object Ktor {
        private val ktorVersion = "1.4.0"

        val commonCore = "io.ktor:ktor-client-core:${ktorVersion}"
        val commonJson = "io.ktor:ktor-client-json:${ktorVersion}"
        val commonLogging = "io.ktor:ktor-client-logging:${ktorVersion}"
        val jvmCore = "io.ktor:ktor-client-core-jvm:${ktorVersion}"
        val androidCore = "io.ktor:ktor-client-okhttp:${ktorVersion}"
        val jvmJson = "io.ktor:ktor-client-json-jvm:${ktorVersion}"
        val jvmLogging = "io.ktor:ktor-client-logging-jvm:${ktorVersion}"
        val ios = "io.ktor:ktor-client-ios:${ktorVersion}"
        val iosCore = "io.ktor:ktor-client-core-native:${ktorVersion}"
        val iosJson = "io.ktor:ktor-client-json-native:${ktorVersion}"
        val iosLogging = "io.ktor:ktor-client-logging-native:${ktorVersion}"
        val commonSerialization = "io.ktor:ktor-client-serialization:${ktorVersion}"
        val androidSerialization = "io.ktor:ktor-client-serialization-jvm:${ktorVersion}"
    }

    object SqlDelight {
        private const val sqlDelightVersion = "1.4.3"

        val runtime = "com.squareup.sqldelight:runtime:$sqlDelightVersion"
        val coroutinesExtension = "com.squareup.sqldelight:coroutines-extensions:$sqlDelightVersion"

        val androidDriver = "com.squareup.sqldelight:android-driver:$sqlDelightVersion"
        val iosDriver = "com.squareup.sqldelight:native-driver:$sqlDelightVersion"
    }

    val coroutinesExcludeNative: ExternalModuleDependency.() -> Unit = {
        exclude(group = "org.jetbrains.kotlinx", module = "kotlinx-coroutines-core-native")
    }

}
