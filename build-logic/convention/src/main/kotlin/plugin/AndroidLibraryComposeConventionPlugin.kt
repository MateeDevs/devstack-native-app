package plugin

import com.android.build.api.dsl.LibraryExtension
import config.configureComposeCompiler
import config.configureComposeDependencies
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.configure

@Suppress("unused")
class AndroidLibraryComposeConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            apply<AndroidLibraryConventionPlugin>()

            extensions.configure<LibraryExtension> {
                configureComposeCompiler(this)
            }

            configureComposeDependencies()
        }
    }
}
