package cz.matee.devstack.plugin

import com.android.build.api.dsl.LibraryExtension
import cz.matee.devstack.config.configureComposeCompiler
import cz.matee.devstack.config.configureComposeDependencies
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
