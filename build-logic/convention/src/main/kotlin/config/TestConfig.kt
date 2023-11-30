package cz.matee.devstack.config

import cz.matee.devstack.extensions.libs
import cz.matee.devstack.extensions.testImplementation
import org.gradle.api.Project
import org.gradle.kotlin.dsl.dependencies

internal fun Project.configureTests() {
    dependencies {
        testImplementation(libs.junit)
        testImplementation(libs.konsist)
    }
}
