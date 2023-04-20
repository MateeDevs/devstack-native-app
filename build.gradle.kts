import org.jetbrains.kotlin.gradle.tasks.KotlinCompile
import tools.Twine

buildscript {
    repositories {
        google()
        mavenCentral()
        maven("https://plugins.gradle.org/m2/")
    }
}

@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.android.library) apply false
    alias(libs.plugins.kotlin.android) apply false
    alias(libs.plugins.kotlin.multiplatform) apply false
    alias(libs.plugins.serialization) apply false
    alias(libs.plugins.sqlDelight) apply false
    alias(libs.plugins.ktlint)
    alias(libs.plugins.versions)
    alias(libs.plugins.versionCatalogUpdate)
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
                "-opt-in=kotlin.RequiresOptIn",
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
        windowsProjectFolderArg = WINDOWS_PROJECT_HOME_FOLDER_ARG,
    ).generate()
}

fun String.isNonStable(): Boolean {
    val stableKeyword = listOf("RELEASE", "FINAL", "GA").any { toUpperCase().contains(it) }
    val regex = "^[0-9,.v-]+(-r)?$".toRegex()
    val isStable = stableKeyword || regex.matches(this)
    return isStable.not()
}

tasks.withType<com.github.benmanes.gradle.versions.updates.DependencyUpdatesTask> {
    rejectVersionIf {
        candidate.version.isNonStable()
    }
}

versionCatalogUpdate {
    sortByKey.set(false)
    keep {
        keepUnusedVersions.set(true)
        keepUnusedLibraries.set(true)
        keepUnusedPlugins.set(true)
    }
}

tasks.create<Delete>("clean") {
    delete(rootProject.buildDir)
}

ktlint {
    filter {
        exclude("**/generated/**")
        include("**/kotlin/**")
    }
}
