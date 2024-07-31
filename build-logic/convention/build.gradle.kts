@Suppress("DSL_SCOPE_VIOLATION") // Remove after upgrading to gradle 8.1
plugins {
    `kotlin-dsl`
    `java-gradle-plugin`
    alias(libs.plugins.ktlint)
}

group = "buildlogic"

java {
    sourceCompatibility = JavaVersion.VERSION_17
    targetCompatibility = JavaVersion.VERSION_17
}

kotlin {
    kotlinDslPluginOptions {
        jvmTarget.set(JavaVersion.VERSION_17.toString())
    }
}

dependencies {
    implementation(files(libs.javaClass.superclass.protectionDomain.codeSource.location))
    compileOnly(libs.androidTools.gradle)
    compileOnly(libs.kotlin.gradlePlugin)
}

gradlePlugin {
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.application.compose,
            pluginName = "AndroidApplicationComposeConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.application.core,
            pluginName = "AndroidApplicationConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.library.compose,
            pluginName = "AndroidLibraryComposeConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.android.library.core,
            pluginName = "AndroidLibraryConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.kmm.library,
            pluginName = "KmmLibraryConventionPlugin",
        )
    }
    plugins {
        plugin(
            dependency = libs.plugins.devstack.kmm.xcframework.library,
            pluginName = "KmmXCFrameworkLibraryConventionPlugin",
        )
    }
}

fun NamedDomainObjectContainer<PluginDeclaration>.plugin(
    dependency: Provider<out PluginDependency>,
    pluginName: String,
) {
    val pluginId = dependency.get().pluginId
    register(pluginId) {
        id = pluginId
        implementationClass = "plugin.$pluginName"
    }
}
