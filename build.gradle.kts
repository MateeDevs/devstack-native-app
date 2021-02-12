import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import java.net.URI

buildscript {
    repositories {
        google()
        mavenCentral()
        jcenter()
    }

    dependencies {
        classpath(kotlin("gradle-plugin", kotlinVersion))
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
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "1.8"
            useIR = true
            freeCompilerArgs += "-Xallow-jvm-ir-dependencies"
        }
    }
}

tasks.create<Delete>("clean") {
    delete(rootProject.buildDir)
}

