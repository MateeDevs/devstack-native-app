package config

import org.gradle.api.Project
import org.gradle.internal.os.OperatingSystem
import java.io.File

fun Project.configureTwine() {
    tasks.register("generateTwine") {
        Twine.generateAllRegularFiles(
            project = project,
            twineFile = "${rootProject.file("twine").absolutePath}/strings.txt",
            moduleName = "android/shared",
        )
    }

    tasks.register("generateErrorsTwine") {
        Twine.generateAllErrorFiles(
            project = project,
            twineFile = "${rootProject.file("twine").absolutePath}/errors.txt",
            targetPath = "${project.rootDir.absolutePath}/shared/base/src/commonMain/moko-resources",
            targetFileName = "strings.xml",
            languages = listOf("sk", "en", "cs"),
            baseLanguage = "en",
        )
    }
}

private object Twine {

    fun generateAllRegularFiles(
        project: Project,
        moduleName: String,
        twineFile: String,
    ) {
        val script =
            when {
                OperatingSystem.current().isLinux || OperatingSystem.current().isMacOsX ->
                    "twine generate-all-localization-files $twineFile ${project.rootDir.absolutePath}/$moduleName/src/main/res/ -f android -n generated_strings.xml -d en -r"

                OperatingSystem.current().isWindows -> "twine generate-all-localization-files $twineFile ${project.rootDir.absolutePath}/$moduleName/src/main/res/ -f android -n generated_strings.xml -d en -r"
                else -> "unsupported"
            }

        project.exec {
            // Add twine into path
            // This should be also refactored
            val twinePath = project.findProperty("twinePath")
            if (twinePath != null) {
                environment["PATH"] =
                    "${environment["PATH"]}${System.getProperty("path.separator")}$twinePath"
            }

            if (OperatingSystem.current().isMacOsX || OperatingSystem.current().isLinux) {
                this.commandLine("sh", "-c", script)
            } else if (OperatingSystem.current().isWindows) {
                this.commandLine("cmd", "/c", script)
            }
        }
    }

    fun generateAllErrorFiles(
        project: Project,
        twineFile: String,
        targetPath: String,
        targetFileName: String,
        languages: List<String>,
        baseLanguage: String,
    ) {
        val scripts = languages.map { language ->
            val path = "$targetPath/${if (language == baseLanguage) "base" else language}"
            val file = "$path/$targetFileName"

            File(path).mkdirs()
            File(file).createNewFile()

            "twine generate-localization-file $twineFile $file -f android --lang $language \n" +
                // Replace occurrences of \" with just a quote
                // https://github.com/icerockdev/moko-resources/issues/462
                "sed -i '.bak' -e 's@\\\\\"@\"@g' \"$file\" \n" +
                // Macos requires inplace backup file... remove it
                "rm \"$file\".bak"
        }
        scripts.forEach { script ->
            project.exec {
                // Add twine into path
                // This should be also refactored
                val twinePath = project.findProperty("twinePath")
                if (twinePath != null) {
                    environment["PATH"] =
                        "${environment["PATH"]}${System.getProperty("path.separator")}$twinePath"
                }

                if (OperatingSystem.current().isMacOsX || OperatingSystem.current().isLinux) {
                    commandLine("sh", "-c", script)
                } else if (OperatingSystem.current().isWindows) {
                    commandLine("cmd", "/c", script)
                }
            }
        }
    }
}
