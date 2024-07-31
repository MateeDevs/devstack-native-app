@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.kmm.xcframework.library)
}

android {
    namespace = "kmp.shared.core"
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
                api(project(":shared:base"))
                api(project(":shared:sample"))
            }
        }
    }
}
