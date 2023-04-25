package cz.matee.devstack.config

import cz.matee.devstack.extensions.getBooleanProperty
import cz.matee.devstack.extensions.getStringProperty
import org.gradle.api.Project
import org.gradle.api.Task
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension
import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType
import org.jetbrains.kotlin.gradle.plugin.mpp.apple.XCFramework
import java.util.Locale

object KmmConfig {
    private fun getXCodeConfiguration(project: Project): String =
        getStringProperty(project, "XCODE_CONFIGURATION", "release")

    private fun isArm64Only(project: Project): Boolean =
        getBooleanProperty(project, "ARM64_ONLY", false)

    fun getCurrentNativeBuildType(project: Project): NativeBuildType {
        val xCodeConfiguration = getXCodeConfiguration(project).toLowerCase(Locale.getDefault())
        println("XCODE_CONFIGURATION: $xCodeConfiguration")
        return if (xCodeConfiguration.contains("debug")) {
            NativeBuildType.DEBUG
        } else {
            NativeBuildType.RELEASE
        }
    }

    val KotlinNativeTarget.asMainSourceSetName: String
        get() = "${this.name}Main"

    fun getSupportedPlatforms(extensions: KotlinMultiplatformExtension, project: Project) =
        with(extensions) {
            println("isArm64Only ${isArm64Only(project)}")
            if (isArm64Only(project)) {
                listOf(iosArm64(), tvosArm64(), tvosX64())
            } else {
                listOf(
                    iosX64(),
                    iosArm64(),
                    iosSimulatorArm64(),
                    tvosX64(),
                    tvosArm64(),
                    tvosSimulatorArm64(),
                )
            }
        }

    fun getSupportedMobilePlatforms(extensions: KotlinMultiplatformExtension, project: Project) =
        with(extensions) {
            println("isArm64Only ${isArm64Only(project)}")
            if (isArm64Only(project)) {
                listOf(iosArm64())
            } else {
                listOf(iosX64(), iosArm64(), iosSimulatorArm64())
            }
        }

    fun getSupportedTvPlatforms(extensions: KotlinMultiplatformExtension, project: Project) =
        with(extensions) {
            println("isArm64Only ${isArm64Only(project)}")
            if (isArm64Only(project)) {
                listOf(tvosArm64())
            } else {
                listOf(tvosX64(), tvosArm64(), tvosSimulatorArm64())
            }
        }

    fun Task.copyXCFramework(projectName: String) {
        val buildPathRelease =
            "build/XCFrameworks/${getCurrentNativeBuildType(project).name.toLowerCase(Locale.getDefault())}/$projectName.xcframework"
        val iosXCBinaryPath = "../ios/DomainLayer/$projectName.xcframework"

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
                    }
                }
            }
        }
    }
}
