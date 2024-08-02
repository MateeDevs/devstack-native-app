@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.kmm.library)
}

android {
    namespace = "kmp.shared.base"
}

multiplatformResources {
    multiplatformResourcesPackage = "kmp.shared.base"
    disableStaticFrameworkWarning = true
}

ktlint {
    filter {
        exclude { entry ->
            entry.file.toString().contains("generated")
        }
    }
}
