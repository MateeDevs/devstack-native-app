plugins {
    id("com.android.library")
    kotlin("android")
}

android {
    compileSdk = Application.Sdk.compile

    defaultConfig {
        minSdk = Application.Sdk.min
        targetSdk = Application.Sdk.target

        testInstrumentationRunner = Dependency.AndroidX.testRunner
    }

    buildFeatures {
        compose = true

        lint {
            lintConfig = File("lint.xml")
        }
    }

    composeOptions {
        kotlinCompilerExtensionVersion = Dependency.Compose.compilerExtensionVersion
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
        getByName("test").java.srcDirs("src/test/kotlin")
        getByName("androidTest").java.srcDirs("src/androidTest/kotlin")
        getByName("release").java.srcDirs("src/release/kotlin")
    }
    namespace = "cz.matee.devstack.kmp.android.recipes"
}

dependencies {
    implementation(project(Project.shared))
    implementation(project(Project.Android.shared))

    implementation(project.dependencies.platform(Dependency.Kotlin.stdlib))
    implementation(Dependency.AndroidX.core)

    implementation(Dependency.Compose.ui)
    implementation(Dependency.Compose.uiTooling)
    implementation(Dependency.Compose.foundation)
    implementation(Dependency.Compose.material)
    implementation(Dependency.Compose.materialIconsCore)
    implementation(Dependency.Compose.materialIconsExtended)

    implementation(Dependency.Compose.Navigation.core)

    implementation(Dependency.Koin.android)
    implementation(Dependency.Koin.compose)

    androidTestImplementation(Dependency.Compose.uiTest)
}