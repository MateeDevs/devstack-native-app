package tools

import extensions.getStringProperty
import org.gradle.api.Project
import org.gradle.internal.os.OperatingSystem

class Twine(
    private val project: Project,
    private val twineFolderArg: String,
    private val windowsProjectFolderArg: String,
    private val moduleName: String,
    private val twineFileName: String
) {

    fun generate() {
        val twineFolder = getStringProperty(project, twineFolderArg, "unknown")

        val script =
            when {
                OperatingSystem.current().isLinux || OperatingSystem.current().isMacOsX ->
                    "twine generate-all-localization-files ${twineFolder}${twineFileName} ${project.rootDir.absolutePath}/$moduleName/src/main/res/ -f android -n generated_strings.xml -d en -r"
                OperatingSystem.current().isWindows -> "twine generate-all-localization-files ${twineFolder}${twineFileName} ${windowsProjectFolderArg}/$moduleName/src/main/res/ -f android -n generated_strings.xml -d en -r"
                else -> "unsupported"
            }

        project.exec {
            // Add twine into path
            //This should be also refactored
            val twinePath = project.findProperty("twinePath")
            if (twinePath != null) environment["PATH"] =
                "${environment["PATH"]}${System.getProperty("path.separator")}$twinePath"

            if (OperatingSystem.current().isMacOsX || OperatingSystem.current().isLinux)
                this.commandLine("sh", "-c", script)
            else if (OperatingSystem.current().isWindows)
                this.commandLine("cmd", "/c", script)
        }


    }


}