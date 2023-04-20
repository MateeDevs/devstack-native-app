@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.ktlint)
}

val appName = "MateeCoreApp"

android {
    compileSdk = libs.versions.sdk.compile.get().toInt()

    defaultConfig {
        applicationId = Application.id

        minSdk = libs.versions.sdk.min.get().toInt()
        targetSdk = libs.versions.sdk.target.get().toInt()

        versionCode = Application.Version.code
        versionName = Application.Version.name

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    signingConfigs {
        named("debug").configure {
            storeFile = file("../../other/keystore/debug.jks")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }

        register("release") {
            storeFile = file("../../other/keystore/release.jks")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }
    }

    buildTypes {
        getByName("debug") {
            isMinifyEnabled = false
            applicationIdSuffix = ".debug"
            signingConfig = signingConfigs.getByName("debug")
        }

        create("alpha") {
            initWith(getByName("release"))
            applicationIdSuffix = ".alpha"
            signingConfig = signingConfigs.getByName("debug")
        }

        getByName("release") {
            isMinifyEnabled = false
            signingConfig = signingConfigs.getByName("release")
        }
    }

    testBuildType = "debug"

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
        getByName("androidTest").java.srcDirs("src/androidTest/kotlin")
        getByName("release").java.srcDirs("src/release/kotlin")
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    buildFeatures {
        compose = true

        lint {
            lintConfig = File("lint.xml")
        }
    }

    composeOptions {
        kotlinCompilerExtensionVersion = libs.versions.composeCompilerExtensionVersion.get()
    }
    namespace = "cz.matee.devstack.kmp"

    applicationVariants.all {
        if (buildType.name != "release") {
            resValue("string", "app_name", "[${buildType.name.capitalize()}]$appName")
        } else {
            resValue("string", "app_name", appName)
        }
    }
}

dependencies {
    implementation(project(Project.shared))
    implementation(project(Project.Android.shared))
    implementation(project(Project.Android.login))
    implementation(project(Project.Android.users))
    implementation(project(Project.Android.profile))
    implementation(project(Project.Android.recipes))
    implementation(project(Project.Android.books))
    implementation(project.dependencies.platform(libs.kotlin.stdlib))
    implementation(libs.androidX.core)
    implementation(libs.compose.ui)
    implementation(libs.compose.foundation)
    implementation(libs.compose.material)
    implementation(libs.activity.compose)
    implementation(libs.navigation.compose)
    implementation(libs.koin.android)
    implementation(libs.koin.compose)
    ktlintRuleset(libs.ktlint.composeRules)
    androidTestImplementation(libs.compose.uiTest)
}
