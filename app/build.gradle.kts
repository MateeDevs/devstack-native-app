plugins {
    id("com.android.application")
    kotlin("android")
    id("kotlin-kapt")
    id("androidx.navigation.safeargs.kotlin")
}

val appName = "MateeCoreApp"

android {
    compileSdkVersion(Application.Sdk.compile)

    defaultConfig {
        applicationId = Application.id

        minSdkVersion(Application.Sdk.min)
        targetSdkVersion(Application.Sdk.target)

        multiDexEnabled = true

        versionCode = Android.versionCode
        versionName = Android.versionName

        testInstrumentationRunner = Android.testInstrumentRunner
        //versionCode gitCommitsCount

        packagingOptions {
            exclude("META-INF/connect-sdk-api-incar-domain.kotlin_module")
            exclude("META-INF/domain.kotlin_module")
            exclude("META-INF/data.kotlin_module")
            exclude("META-INF/infrastructure.kotlin_module")
            exclude("META-INF/presentation.kotlin_module")
            exclude("META-INF/LICENSE.md")
            exclude("META-INF/LICENSE-notice.md")
        }
    }

    signingConfigs {
        named("debug").configure {
            storeFile = file("../other/keystore/debug.jks")
            storePassword = "android"
            keyAlias = "androiddebugkey"
            keyPassword = "android"
        }

        register("release") {
            storeFile = file("../other/keystore/release.jks")
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
        sourceCompatibility = Android.sourceCompatibilityJava
        targetCompatibility = Android.targetCompatibilityJava
    }

    buildFeatures {
        dataBinding = true
        lintOptions {
            lintConfig = File("lint.xml")
        }
    }

    applicationVariants.all {
        if (buildType.name != "release") {
            resValue("string", "app_name", "[${buildType.name.capitalize()}]$appName")
        } else {
            resValue("string", "app_name", appName)
        }
    }
}


dependencies {
    implementation(project(":shared"))

    implementation("org.jetbrains.kotlin:kotlin-stdlib:$kotlin_version")
    implementation("androidx.core:core-ktx:1.3.2")
    implementation("androidx.appcompat:appcompat:1.2.0")
    implementation("com.google.android.material:material:1.3.0")

}


tasks {
    val androidSourcesJar by creating(Jar::class) {
        archiveClassifier.set("sources")
        from(android.sourceSets["main"].java.srcDirs)
    }

    artifacts {
        add("archives", androidSourcesJar)
    }
}