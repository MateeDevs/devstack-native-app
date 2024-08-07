import constants.Application
import constants.ProjectConstants

@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    alias(libs.plugins.devstack.kmm.xcframework.library)
}

android {
    namespace = "kmp.shared.core"
}

multiplatformResources {
    resourcesPackage.set("kmp.shared.base")
    configureCopyXCFrameworkResources(ProjectConstants.iosShared)
}

ktlint {
    filter {
        exclude { entry ->
            entry.file.toString().contains("generated")
        }
    }
}

dependencies {
    commonMainApi(project(":shared:base"))
    commonMainApi(project(":shared:sample"))
    commonMainApi(project(":shared:samplesharedviewmodel"))
    commonMainApi(project(":shared:sampleComposeMultiplatform"))
}
