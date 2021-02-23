plugins {
    id("com.android.library")
    kotlin("android")
}

android {
    compileSdkVersion(Application.Sdk.compile)

    defaultConfig {
        minSdkVersion(Application.Sdk.min)
        targetSdkVersion(Application.Sdk.target)

        versionCode = Application.Version.code
        versionName = Application.Version.name

        testInstrumentationRunner("androidx.test.runner.AndroidJUnitRunner")
    }

    buildFeatures {
        dataBinding = true
        compose = true

        lintOptions {
            lintConfig = File("lint.xml")
        }
    }

    composeOptions {
        kotlinCompilerVersion = kotlinVersion
        kotlinCompilerExtensionVersion = Dependency.Compose.version
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
        getByName("androidTest").java.srcDirs("src/androidTest/kotlin")
        getByName("release").java.srcDirs("src/release/kotlin")
    }
}

dependencies {
    implementation(project(Project.shared))

    implementation(Dependency.Kotlin.stdlib)
    implementation(Dependency.AndroidX.core)
    implementation(Dependency.AndroidX.appCompat)
    implementation(Dependency.AndroidX.material)

    implementation(Dependency.AndroidX.Lifecycle.core)
    implementation(Dependency.AndroidX.Lifecycle.runtime)

    implementation(Dependency.Play.location)

    implementation(Dependency.Compose.ui)
    implementation(Dependency.Compose.uiTooling)
    implementation(Dependency.Compose.foundation)
    implementation(Dependency.Compose.navigation)
    implementation(Dependency.Compose.material)
    implementation(Dependency.Compose.materialIconsCore)

    implementation(Dependency.Compose.Accompanist.insets)

    implementation(Dependency.Koin.android)
    implementation(Dependency.Koin.compose)

    androidTestImplementation(Dependency.Compose.uiTest)
}