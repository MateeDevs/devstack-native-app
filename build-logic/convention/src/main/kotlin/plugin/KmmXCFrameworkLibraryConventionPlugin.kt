package plugin

import com.android.build.api.dsl.LibraryExtension
import config.KmmConfig.copyXCFramework
import config.configureBuildVariants
import config.kmm
import constants.ProjectConstants
import extensions.libs
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.configure
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension

@Suppress("unused")
class KmmXCFrameworkLibraryConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            apply<KmmLibraryConventionPlugin>()

            extensions.configure<KotlinMultiplatformExtension> {
                kmm(
                    project = project,
                    nativeName = ProjectConstants.iosShared,
                )
            }

            // There is a bug in Xcode 15.3 - archive validation fails if SDKs support a lower minimum OS version than the app
            // Konan plugin sets minVersion.ios to 12.0 by default, but we have 15.0 in our app
            // This line changes Konan property to 15.0
//            tasks.withType<KotlinNativeLink> {
//                kotlinOptions.freeCompilerArgs += "-Xoverride-konan-properties=minVersion.ios=15.0"
//            }

            tasks.register("buildXCFramework") {
                dependsOn("assemble${ProjectConstants.iosShared}XCFramework")
            }

            tasks.register("copyXCFramework") {
                copyXCFramework(ProjectConstants.iosShared)
            }
        }
    }
}