import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

buildscript {
    repositories {
        google()
        mavenCentral()
        jcenter()
    }

    dependencies {
        classpath(GradlePlugins.androidGradle)
        classpath(GradlePlugins.kotlinSerialiation)
        classpath(GradlePlugins.safeArgs)
        classpath(GradlePlugins.sqlDelight)
        classpath(kotlin("gradle-plugin", kotlin_version))

    }
}

allprojects {
    repositories {
        //mavenLocal()
        google()
        mavenCentral()
        jcenter()
        maven(url = "https://kotlin.bintray.com/kotlinx")
        maven(url = "https://dl.bintray.com/touchlabpublic/kotlin")
        maven(url = "https://oss.sonatype.org/content/repositories/snapshots/")
    }

    configurations.all {
        // Don't cache changing modules at all.
        resolutionStrategy.cacheChangingModulesFor(0, "seconds")
        resolutionStrategy.cacheDynamicVersionsFor(2, "minutes")
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "1.8"
        }
    }

    tasks.withType<KotlinCompile> {
        kotlinOptions {
            jvmTarget = "1.8"
            freeCompilerArgs = listOf(
                "-Xopt-in=kotlinx.coroutines.ExperimentalCoroutinesApi",
                "-Xopt-in=kotlinx.coroutines.FlowPreview",
                "-XXLanguage:+InlineClasses"
            )
        }
    }


}

tasks.create<Delete>("clean") {
    delete(rootProject.buildDir)
}

