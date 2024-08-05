package config

import com.android.build.api.dsl.CommonExtension
import extensions.androidTestImplementation
import extensions.apply
import extensions.implementation
import extensions.ktlintRuleset
import extensions.libs
import extensions.pluginManager
import org.gradle.api.Project
import org.gradle.kotlin.dsl.apply
import org.gradle.kotlin.dsl.dependencies

internal fun Project.configureComposeCompiler(
    commonExtension: CommonExtension<*, *, *, *, *, *>,
) = with(commonExtension) {
    buildFeatures {
        compose = true
    }

    pluginManager {
        apply(libs.plugins.jetbrains.compose.compiler)
    }
}

internal fun Project.configureComposeDependencies() {
    dependencies {
        implementation(libs.androidX.core)
        implementation(libs.compose.ui)
        implementation(libs.compose.foundation)
        implementation(libs.compose.material)
        implementation(libs.compose.materialIconsCore)
        implementation(libs.compose.uiTooling)
        implementation(libs.activity.compose)
        implementation(libs.navigation.compose)
        implementation(libs.koin.android)
        implementation(libs.koin.compose)
        implementation(libs.accompanist.navigationMaterial)
        androidTestImplementation(libs.compose.uiTest)
    }
}

internal fun Project.configureComposeLint() {
    dependencies {
        ktlintRuleset(libs.ktlint.composeRules)
    }
}
