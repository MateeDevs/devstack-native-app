package config

import extensions.getBooleanProperty
import extensions.getStringProperty
import extensions.libs
import org.gradle.api.Project
import org.gradle.api.Task
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension
import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType
import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework
import java.util.Locale

object KmmConfig {
    private fun getXCodeConfiguration(project: Project): String =
        getStringProperty(project, "XCODE_CONFIGURATION", "debug")

    private fun includeX86(project: Project): Boolean =
        getBooleanProperty(project, "X86", false)

    private fun includeArm64(project: Project): Boolean =
        getBooleanProperty(project, "ARM64", true)

    private fun includeArm64Sim(project: Project): Boolean =
        getBooleanProperty(project, "ARM64SIM", true)

    fun getCurrentNativeBuildType(project: Project): NativeBuildType {
        val xCodeConfiguration = getXCodeConfiguration(project).lowercase(Locale.getDefault())
        println("XCODE_CONFIGURATION: $xCodeConfiguration")
        return if (xCodeConfiguration.contains("debug")) {
            NativeBuildType.DEBUG
        } else {
            NativeBuildType.RELEASE
        }
    }

    val KotlinNativeTarget.asMainSourceSetName: String
        get() = "${this.name}Main"

    fun getSupportedMobilePlatforms(extensions: KotlinMultiplatformExtension, project: Project) =
        with(extensions) {
            val architecture = mutableListOf<KotlinNativeTarget>()
            if (includeX86(project)) architecture.add(iosX64())
            if (includeArm64(project)) architecture.add(iosArm64())
            if (includeArm64Sim(project)) architecture.add(iosSimulatorArm64())
            architecture
        }

    fun getSupportedTvPlatforms(extensions: KotlinMultiplatformExtension, project: Project) =
        with(extensions) {
            val architecture = mutableListOf<KotlinNativeTarget>()
            if (includeX86(project)) architecture.add(tvosX64())
            if (includeArm64(project)) architecture.add(tvosArm64())
            if (includeArm64Sim(project)) architecture.add(tvosSimulatorArm64())
            architecture
        }

    fun Task.copyXCFramework(projectName: String) {
        val buildPathRelease =
            "build/XCFrameworks/${getCurrentNativeBuildType(project).name.lowercase(Locale.getDefault())}/$projectName.xcframework"
        val iosXCBinaryPath = "../../ios/DomainLayer/$projectName.xcframework"

        project.delete(iosXCBinaryPath)
        project.copy {
            from(buildPathRelease)
            into(iosXCBinaryPath)
        }
    }
}

fun KotlinMultiplatformExtension.kmm(
    project: Project,
    nativeName: String,
    tvOSEnabled: Boolean = false,
) {
    with(project) {
        val xcf = XCFramework(nativeName)
        KmmConfig.getSupportedMobilePlatforms(this@kmm, project).forEach {
            it.binaries.framework {
                if (this.buildType == KmmConfig.getCurrentNativeBuildType(project)) {
                    baseName = nativeName
                    isStatic = false
                    xcf.add(this)
                    export(libs.mokoResources)
                    export(project(":shared:base"))
                    export(project(":shared:sample"))
                    export(project(":shared:samplesharedviewmodel"))
                    export(project(":shared:sampleComposeMultiplatform"))
                }
            }
        }
        if (tvOSEnabled) {
            KmmConfig.getSupportedTvPlatforms(this@kmm, project).forEach {
                it.binaries.framework {
                    if (this.buildType == KmmConfig.getCurrentNativeBuildType(project)) {
                        baseName = nativeName
                        isStatic = false
                        xcf.add(this)
                        export(libs.mokoResources)
                        export(project(":shared:base"))
                        export(project(":shared:sample"))
                        export(project(":shared:samplesharedviewmodel"))
                        export(project(":shared:sampleComposeMultiplatform"))
                    }
                }
            }
        }
    }
}
