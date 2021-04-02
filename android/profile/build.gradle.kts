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
        compose = true

        lint {
            lintConfig = File("lint.xml")
        }
    }

    composeOptions {
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
    implementation(project(Project.Android.shared))

    implementation(Dependency.Kotlin.stdlib)
    implementation(Dependency.AndroidX.core)

    implementation(Dependency.Matee.Core.compose)

    implementation(Dependency.Compose.ui)
    implementation(Dependency.Compose.uiTooling)
    implementation(Dependency.Compose.foundation)
    implementation(Dependency.Compose.material)
    implementation(Dependency.Compose.materialIconsCore)

    implementation(Dependency.Compose.Navigation.core)
    implementation(Dependency.Compose.ConstraintLayout.core)
    implementation(Dependency.Compose.Accompanist.insets)

    implementation(Dependency.Koin.android)
    implementation(Dependency.Koin.compose)

    androidTestImplementation(Dependency.Compose.uiTest)
}