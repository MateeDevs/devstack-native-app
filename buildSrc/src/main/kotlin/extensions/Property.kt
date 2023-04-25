package extensions

import org.gradle.api.Project
import java.util.Properties

fun getStringProperty(project: Project, propertyArg: String, defaultValue: String) =
    project.getPropertyValue(propertyArg, defaultValue)

fun getIntegerProperty(project: Project, propertyArg: String, defaultValue: Int) =
    project.getPropertyValue(propertyArg, defaultValue).toInt()

fun getBooleanProperty(project: Project, propertyArg: String, defaultValue: Boolean) =
    project.getPropertyValue(propertyArg, defaultValue).toBoolean()

private fun <T> Project.getPropertyValue(propertyArg: String, defaultValue: T): String {
    var value: String? = null

    // task argument -PversionCode=...
    if (project.rootProject.hasProperty(propertyArg)) {
        project.rootProject.property(propertyArg)?.let {
            value = it.toString()
        }
    }

    // local.properties
    if (value == null && project.rootProject.file("local.properties").canRead()) {
        val properties = Properties()
        properties.load(project.rootProject.file("local.properties").inputStream())

        value = properties.getProperty(propertyArg)
    }

    // gradle.properties
    if (value == null) {
        value = project.findProperty(propertyArg)?.toString()
    }

    return value ?: defaultValue.toString()
}
