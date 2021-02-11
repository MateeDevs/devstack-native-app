import org.gradle.api.JavaVersion

@Deprecated("Do not use")
private object Versions {

    const val supportLib = "1.2.0"
    const val archLifecycle = "2.2.0-rc01"
    const val archNavigation = "2.2.0-rc01"
    const val safeArgs = archNavigation
    const val archPersistence = "2.2.1"
    const val databinding = "3.3.1"

    const val kotlin = "1.3.21"
    const val coroutinesCore = "1.3.2"
    const val coroutinesAndroid = "1.3.2"
    const val coroutinesTest = "1.3.2"

    const val gradle = "5.2.1"
    const val gradleBuildTools = "4.0.0"

    const val timber = "4.7.1"
    const val timberKtx = "0.1.0"
    const val koin = "2.1.6"
    const val espresso = "3.1.0"
    const val junit = "4.12"
    const val kotlinTest = "3.3.2"
    const val mockk = "1.9.1"
    const val gson = "2.8.5"
    const val supportTest = "1.1.0"
    const val androidxTestCore = "1.1.0"
    const val junitExt = "1.1.0"
    const val archCore = "2.0.0-rc01"
    const val uiAutomator = "2.2.0"
    const val materialDesign = "28.0.0"
    const val viewPager2 = "1.0.0-alpha03"
    const val barista = "3.0.0"
    const val koinTest = "2.0.0-GA4"
    const val stetho = "1.5.1"
    const val flipper = "0.26.0"
    const val soloader = "0.8.0"

    const val constraintLayout = "1.1.3"
    const val androidKtx = "1.3.2"

    const val retrofit = "2.6.0"
    const val okHttp3 = "3.10.0"

    const val fastAdapter = "5.0.0-a06"
}

/* =============================  ANDROID ============================= */
@Deprecated("")
object Android {
    val applicationId = "cz.matee.devstack"
    val testId = "cz.matee.devstack.test"

    val minSdk = 21
    val targetSdk = 28
    val compileSdk = 28

    val versionCode = 1
    val versionName = "1"

    val testInstrumentRunner = "androidx.test.runner.AndroidJUnitRunner"
    val sourceCompatibilityJava = JavaVersion.VERSION_1_8
    val targetCompatibilityJava = JavaVersion.VERSION_1_8
}

/* =============================  BUILD-PLUGINS ======================= */
@Deprecated("Do not use")
object Dependencies {

    /* =============================  KOTLIN ============================== */
    @Deprecated("")
    object Kotlin {
        val kotlinStbLib = "org.jetbrains.kotlin:kotlin-stdlib-jdk8:${Versions.kotlin}"
        val coroutinesCore =
            "org.jetbrains.kotlinx:kotlinx-coroutines-core:${Versions.coroutinesCore}"
        val coroutinesAndroid =
            "org.jetbrains.kotlinx:kotlinx-coroutines-android:${Versions.coroutinesAndroid}"
    }

    /* =============================  LIBS ================================ */
    @Deprecated("")
    object Libs {
        val appCompat = "androidx.appcompat:appcompat:${Versions.supportLib}"
        val supportFragment = "androidx.fragment:fragment:${Versions.supportLib}"
        val constraintLayout =
            "androidx.constraintlayout:constraintlayout:${Versions.constraintLayout}"
        val databinding = "androidx.databinding:databinding-compiler:${Versions.databinding}"

        val androidKTX = "androidx.core:core-ktx:${Versions.androidKtx}"
        val lifecycleExtension = "androidx.lifecycle:lifecycle-extensions:${Versions.archLifecycle}"
        val lifecycleViewModelKtx =
            "androidx.lifecycle:lifecycle-viewmodel-ktx:${Versions.archLifecycle}"
        val lifecycleLiveDataKtx =
            "androidx.lifecycle:lifecycle-livedata-ktx:${Versions.archLifecycle}"
        val lifecycleRuntimeKtx =
            "androidx.lifecycle:lifecycle-runtime-ktx:${Versions.archLifecycle}"
        val lifecycleCompiler = "androidx.lifecycle:lifecycle-compiler:${Versions.archLifecycle}"

        val roomCompiler = "androidx.room:room-compiler:${Versions.archPersistence}"
        val roomRuntime = "androidx.room:room-runtime:${Versions.archPersistence}"
        val roomKtx = "androidx.room:room-ktx:${Versions.archPersistence}"

        val navigationFragment =
            "androidx.navigation:navigation-fragment-ktx:${Versions.archNavigation}"
        val navigationUI = "androidx.navigation:navigation-ui-ktx:${Versions.archNavigation}"

        val koinScope =
            "org.koin:koin-androidx-scope:${Versions.koin}" // Koin Android Scope feature
        val koinAndroid = "org.koin:koin-android:${Versions.koin}"
        val koinViewModel =
            "org.koin:koin-androidx-viewmodel:${Versions.koin}" // Koin Android ViewModel feature

        val materialDesign = "com.google.android.material:material:1.2.1"
        val viewPager2 = "androidx.viewpager2:viewpager2:${Versions.viewPager2}"
        val stetho = "com.facebook.stetho:stetho:${Versions.stetho}"
        val flipper = "com.facebook.flipper:flipper:${Versions.flipper}"
        val flipperNetwork = "com.facebook.flipper:flipper-network-plugin:${Versions.flipper}"
        val flipperRelease = "com.facebook.flipper:flipper-noop:${Versions.flipper}"
        val soloader = "com.facebook.soloader:soloader:${Versions.soloader}"

        val timber = "com.jakewharton.timber:timber:${Versions.timber}"

        val retrofit = "com.squareup.retrofit2:retrofit:${Versions.retrofit}"
        val gsonConverter = "com.squareup.retrofit2:converter-gson:${Versions.retrofit}"
        val okHttp = "com.squareup.okhttp3:okhttp:${Versions.okHttp3}"

        // fast adapter
        val fastAdapter = "com.mikepenz:fastadapter:${Versions.fastAdapter}"
        val fastAdapterDiff = "com.mikepenz:fastadapter-extensions-diff:${Versions.fastAdapter}"
        val fastAdapterDrag = "com.mikepenz:fastadapter-extensions-drag:${Versions.fastAdapter}"
        val fastAdapterPaged = "com.mikepenz:fastadapter-extensions-paged:${Versions.fastAdapter}"
        val fastAdapterScroll = "com.mikepenz:fastadapter-extensions-scroll:${Versions.fastAdapter}"
        val fastAdapterSwipe = "com.mikepenz:fastadapter-extensions-swipe:${Versions.fastAdapter}"
        val fastAdapterUi = "com.mikepenz:fastadapter-extensions-ui:${Versions.fastAdapter}"
        val fastAdapterUtils = "com.mikepenz:fastadapter-extensions-utils:${Versions.fastAdapter}"
        val fastAdapterExpandable = "com.mikepenz:fastadapter-extensions-expandable:${Versions.fastAdapter}"

    }

    /* =============================  TEST-LIBS =========================== */
    @Deprecated("")
    object TestLibs {
        val androidxTestCore = "androidx.test:core:${Versions.androidxTestCore}"
        val junit = "junit:junit:${Versions.junit}"
        val junitExt = "androidx.test.ext:junit:${Versions.junitExt}"
        val espressoCore = "com.android.support.test.espresso:espresso-core:${Versions.espresso}"
        val kotlinTest = "io.kotlintest:kotlintest-runner-junit5:${Versions.kotlinTest}"
        val mockkUnit = "io.mockk:mockk:${Versions.mockk}"
        val mockkInstrument = "io.mockk:mockk-android:${Versions.mockk}"
        val testRunner = "androidx.test:runner:${Versions.supportTest}"
        val testRules = "androidx.test:rules:${Versions.supportTest}"
        val archCoreTest = "androidx.arch.core:core-testing:${Versions.archCore}"
        val uiAutomator = "androidx.test.uiautomator:uiautomator:${Versions.uiAutomator}"
        val kotlinTestRunner = "io.kotlintest:kotlintest-runner-junit5:${Versions.kotlinTest}"
        val kotlinCoroutinesTest =
            "org.jetbrains.kotlinx:kotlinx-coroutines-core:${Versions.coroutinesTest}"
        val testRoom = "androidx.room:room-testing:${Versions.archPersistence}"
        val barista = "com.schibsted.spain:barista:${Versions.barista}"
        val koinTest = "org.koin:koin-test:${Versions.koinTest}"
    }
}
