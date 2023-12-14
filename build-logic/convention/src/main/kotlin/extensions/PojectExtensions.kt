package extensions

import com.android.build.api.dsl.CommonExtension
import com.android.build.gradle.LibraryExtension
import com.android.build.gradle.internal.dsl.BaseAppModuleExtension
import org.gradle.api.Action
import org.gradle.api.NamedDomainObjectContainer
import org.gradle.api.Project
import org.gradle.api.plugins.JavaPluginExtension
import org.gradle.api.plugins.PluginManager
import org.gradle.api.provider.Provider
import org.gradle.kotlin.dsl.the
import org.gradle.plugin.use.PluginDependency
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension
import org.jetbrains.kotlin.gradle.dsl.kotlinExtension

val Project.libs get() = the<org.gradle.accessors.dm.LibrariesForLibs>()

fun PluginManager.apply(plugin: Provider<PluginDependency>) {
    apply(plugin.get().pluginId)
}

val Project.multiplatform: KotlinMultiplatformExtension
    get() = kotlinExtension as KotlinMultiplatformExtension

fun Project.multiplatform(block: KotlinMultiplatformExtension.() -> Unit) {
    multiplatform.apply(block)
}

fun Project.pluginManager(block: PluginManager.() -> Unit) {
    pluginManager.apply(block)
}

fun Project.android(block: CommonExtension<*, *, *, *, *>.() -> Unit) {
    extension("android", block)
}

fun Project.androidApp(block: BaseAppModuleExtension.() -> Unit) {
    extension("android", block)
}

fun Project.androidLibrary(block: LibraryExtension.() -> Unit) {
    extension("android", block)
}

fun Project.java(block: JavaPluginExtension.() -> Unit) {
    extension("java", block)
}

inline fun <reified T : Any> Project.extension(name: String, block: Action<T>) {
    extensions.configure(name, block)
//    extensions.findByName(name)?.let { it as? T }?.apply(block)
//        ?: error("Extension $name missing")
}

fun <BuildTypeT> NamedDomainObjectContainer<BuildTypeT>.demo(action: BuildTypeT.() -> Unit) {
    create("demo", action)
}
