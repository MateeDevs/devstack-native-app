@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.kmm.library)
}

android {
    namespace = "kmp.shared.samplesharedviewmodel"
}

ktlint {
    filter {
        exclude { entry ->
            entry.file.toString().contains("generated")
        }
    }
}

kotlin {
    sourceSets {
        commonMain {
            dependencies {
                implementation(project(":shared:base"))
                implementation(project(":shared:sample"))
            }
        }
    }
}
