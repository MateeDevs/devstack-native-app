@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.kmm.library)
    id("com.google.devtools.ksp") version "1.8.0-1.0.9"
    id("com.rickclephas.kmp.nativecoroutines") version "1.0.0-ALPHA-10"
}

android {
    namespace = "cz.matee.devstack.shared"
}

sqldelight {
    database("Database") {
        packageName = "cz.matee.devstack.kmp"
    }
}

kotlin.sourceSets.all {
    languageSettings.optIn("kotlin.experimental.ExperimentalObjCName")
}

ktlint {
    filter {
        exclude { entry ->
            entry.file.toString().contains("generated")
        }
    }
}
