package cz.matee.devstack.plugin

import cz.matee.devstack.config.configureComposeCompiler
import cz.matee.devstack.config.configureComposeDependencies
import cz.matee.devstack.config.configureComposeLint
import cz.matee.devstack.extensions.androidApp
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply

@Suppress("unused")
class AndroidApplicationComposeConventionPlugin : Plugin<Project> {

    override fun apply(target: Project) {
        with(target) {
            apply<AndroidApplicationConventionPlugin>()

            androidApp {
                configureComposeCompiler(this)
            }
            configureComposeDependencies()
            configureComposeLint()
        }
    }
}
