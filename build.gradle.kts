import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import tools.Twine

buildscript {
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath(libs.kotlin.gradlePlugin)
        classpath(libs.androidTools.gradle)
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "17"
            freeCompilerArgs = freeCompilerArgs + listOf(
                "-Xallow-jvm-ir-dependencies",
                "-opt-in=kotlin.RequiresOptIn"
            )
        }
    }
}

tasks.register("generateLocalizations") {
    Twine(
        project = project,
        twineFolderArg = TWINE_HOME_FOLDER_ARG,
        twineFileName = "devstack/strings.txt",
        moduleName = "android/shared",
        windowsProjectFolderArg = WINDOWS_PROJECT_HOME_FOLDER_ARG
    ).generate()
}


tasks.create<Delete>("clean") {
    delete(rootProject.buildDir)
}

