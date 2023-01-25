package plugin.plugin

import com.android.build.api.dsl.BuildFeatures
import com.android.build.api.dsl.Lint
import com.android.build.gradle.AppExtension
import com.android.build.gradle.BaseExtension
import com.android.build.gradle.LibraryExtension
import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.api.Task
import org.gradle.api.plugins.JavaPluginExtension
import org.gradle.api.tasks.SourceSetContainer
import org.gradle.kotlin.dsl.findByType


abstract class BasePlugin(private val configuration: Project.() -> Unit) : Plugin<Project> {

    final override fun apply(project: Project) {
        configuration(project)
    }

    protected companion object {
        fun Project.android(block: BaseExtension.() -> Unit) {
            extension(block)
        }

        fun Project.java(block: JavaPluginExtension.() -> Unit) {
            extension(block)
        }

        fun BaseExtension.buildFeatures(configure: BuildFeatures.() -> Unit) {
            buildFeatures.configure()
        }

        fun BaseExtension.lint(project: Project, configure: Lint.() -> Unit) {
            when (val ext = project.extensions.findByName("android")) {
                is LibraryExtension -> ext.lint
                is AppExtension -> null // App extensions does not have a lint ? 🤔
                else -> null
            }?.configure()
        }

        fun Project.tasks(configure: Task.() -> Unit) {
            tasks(configure)
        }

        inline fun <reified T : Any> Project.extension(block: T.() -> Unit) {
            extensions.findByType<T>()?.apply(block)
        }

        val Project.sourceSets: SourceSetContainer?
            get() = extensions.findByName("sourceSets") as? SourceSetContainer

        @Suppress("UNCHECKED_CAST")
        fun <T> Project.typedProperty(name: String): T? = findProperty(name) as T?
    }
}
