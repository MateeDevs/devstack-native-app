import extensions.getStringProperty
import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import tools.Twine
import java.net.URI

buildscript {
    repositories {
        google()
        mavenCentral()
        jcenter()
    }

    dependencies {
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:1.4.30")
        classpath(GradlePlugins.androidGradle)
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
        jcenter()
        maven {
            url = URI.create("https://dl.bintray.com/ekito/koin")
        }
        maven {
            name = "Core"
            url = uri("https://maven.pkg.github.com/MateeDevs/core-and-lib")
            credentials {
                username = getStringProperty(project, GITHUB_USER, "unknown")
                password = getStringProperty(project, GITHUB_PAT, "unknown")
            }
        }
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "1.8"
            useIR = true
            freeCompilerArgs += "-Xallow-jvm-ir-dependencies"
        }
    }
}

tasks.register("generateLocalizations") {
    Twine(
        project = project,
        twineFolderArg = TWINE_HOME_FOLDER_ARG,
        twineFileName = "devstack/strings.txt",
        moduleName = "android/shared",
        bundlerScriptPath = "${rootDir.absolutePath}/other/tools/run_bundler.sh",
        windowsProjectFolderArg = WINDOWS_PROJECT_HOME_FOLDER_ARG
    ).generate()
}


tasks.create<Delete>("clean") {
    delete(rootProject.buildDir)
}

