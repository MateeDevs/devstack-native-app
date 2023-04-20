@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.android.library)
    alias(libs.plugins.kotlin.android)
    alias(libs.plugins.ktlint)
}

android {
    compileSdk = libs.versions.sdk.compile.get().toInt()

    defaultConfig {
        minSdk = libs.versions.sdk.min.get().toInt()
        targetSdk = libs.versions.sdk.target.get().toInt()

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
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

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
        getByName("androidTest").java.srcDirs("src/androidTest/kotlin")
        getByName("release").java.srcDirs("src/release/kotlin")
    }
    namespace = "com.example.profile"
}

dependencies {
    implementation(project(Project.shared))
    implementation(project(Project.Android.shared))

    implementation(project.dependencies.platform(libs.kotlin.stdlib))
    implementation(libs.androidX.core)
    implementation(libs.compose.ui)
    implementation(libs.compose.uiTooling)
    implementation(libs.compose.foundation)
    implementation(libs.compose.material)
    implementation(libs.compose.materialIconsCore)
    implementation(libs.navigation.compose)
    implementation(libs.constraintLayout.compose)
    implementation(libs.koin.android)
    implementation(libs.koin.compose)
    implementation(libs.kotlinx.immutableCollections)
    ktlintRuleset(libs.ktlint.composeRules)
    androidTestImplementation(libs.compose.uiTest)
}
