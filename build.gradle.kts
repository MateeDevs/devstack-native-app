import com.github.benmanes.gradle.versions.updates.DependencyUpdatesTask

configurations {
    register("justForSize")
}

@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.android.application) apply false
    alias(libs.plugins.android.library) apply false
    alias(libs.plugins.kotlin.android) apply false
    alias(libs.plugins.kotlin.multiplatform) apply false
    alias(libs.plugins.serialization) apply false
    alias(libs.plugins.sqlDelight) apply false
    alias(libs.plugins.ktlint) apply false
    alias(libs.plugins.mokoResources) apply false
    alias(libs.plugins.versions)
    alias(libs.plugins.versionCatalogUpdate)
}

fun String.isNonStable(): Boolean {
    val stableKeyword = listOf("RELEASE", "FINAL", "GA").any { toUpperCase().contains(it) }
    val regex = "^[0-9,.v-]+(-r)?$".toRegex()
    val isStable = stableKeyword || regex.matches(this)
    return isStable.not()
}

tasks.withType<DependencyUpdatesTask> {
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

dependencies {
    add("justForSize",libs.video.transcoder)
    add("justForSize",libs.lightCompressor)
    add("justForSize",libs.linkedIn.litr)
}

tasks.register("dependencySize") {
    doLast {
        var depLength = 0L
        configurations.get("justForSize").forEach {
            println("${it} is ${it.length()} bytes")
            depLength += it.length()
        }
        println("Total size of justForSize configuration is $depLength")
    }
}
