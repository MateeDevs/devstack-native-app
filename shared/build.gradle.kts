@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.kmm.library)
}

android {
    namespace = "kmp.shared"
}

multiplatformResources {
    multiplatformResourcesPackage = "kmp.shared"
    disableStaticFrameworkWarning = true
}

sqldelight {
    database("Database") {
        packageName = "kmp"
    }
}

kotlin {
    sourceSets {
        all {
            languageSettings.optIn("org.mobilenativefoundation.store.core5.ExperimentalStoreApi")
        }
    }
}

ktlint {
    filter {
        exclude { entry ->
            entry.file.toString().contains("generated")
        }
    }
}
