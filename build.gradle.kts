import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import tools.Twine

buildscript {
    repositories {
        google()
        mavenCentral()
        jcenter()
    }

    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
        classpath("com.android.tools.build:gradle:7.2.0")
        classpath(GradlePlugins.sqlDelight)
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        jcenter() // TODO remove as soon as ve get rid of all of the dependencies
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "1.8"
            freeCompilerArgs = freeCompilerArgs + listOf(
                "-Xallow-jvm-ir-dependencies",
                "-Xopt-in=kotlin.RequiresOptIn"
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

