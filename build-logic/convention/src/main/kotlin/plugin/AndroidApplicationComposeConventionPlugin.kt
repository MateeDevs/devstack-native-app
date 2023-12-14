package plugin

import config.configureComposeCompiler
import config.configureComposeDependencies
import config.configureComposeLint
import extensions.androidApp
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
