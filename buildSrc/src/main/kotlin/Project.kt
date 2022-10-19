import extensions.getStringProperty
import extensions.getBooleanProperty
import org.gradle.api.Project
import org.jetbrains.kotlin.gradle.dsl.KotlinMultiplatformExtension
import org.jetbrains.kotlin.gradle.plugin.mpp.KotlinNativeTarget
import org.jetbrains.kotlin.gradle.plugin.mpp.NativeBuildType

const val TWINE_HOME_FOLDER_ARG = "twineLocalizationFolder"
const val WINDOWS_PROJECT_HOME_FOLDER_ARG = "projectHomeFolder"
const val GITHUB_USER = "githubUser"
const val GITHUB_PAT = "githubPAT"

const val kotlinVersion = "1.7.10"

object Project {
    const val shared = ":shared"
    const val iosShared = "DevstackKmpShared"

    object Android {
        private const val root = ":android"
        const val shared = "$root:shared"
        const val login = "$root:login"
        const val profile = "$root:profile"
        const val users = "$root:users"
        const val recipes = "$root:recipes"
        const val books = "$root:books"
    }
}

object GradlePlugins {

    private const val safeArgsVersion = "2.3.5"
    private const val sqlDelightVersion = Dependency.SqlDelight.version

    const val kotlinSerialization = "org.jetbrains.kotlin:kotlin-serialization:1.3.1"
    const val safeArgs = "androidx.navigation:navigation-safe-args-gradle-plugin:${safeArgsVersion}"
    const val sqlDelight = "com.squareup.sqldelight:gradle-plugin:$sqlDelightVersion"
}

object KmmConfig {
    private fun getXCodeConfiguration(project: Project): String =
        getStringProperty(project, "XCODE_CONFIGURATION", "release")

    private fun isArm64Only(project: Project): Boolean = getBooleanProperty(project, "ARM64_ONLY", false)

    fun getCurrentNativeBuildType(project: Project): NativeBuildType {
        val xCodeConfiguration = getXCodeConfiguration(project)
        println("XCODE_CONFIGURATION: $xCodeConfiguration")
        return when (getXCodeConfiguration(project)) {
            "Release" -> NativeBuildType.RELEASE
            "Debug" -> NativeBuildType.DEBUG
            else -> NativeBuildType.RELEASE
        }
    }


    val KotlinNativeTarget.asMainSourceSetName: String
        get() = "${this.name}Main"

    fun getSupportedPlatforms(extensions: KotlinMultiplatformExtension, project: Project) =
        with(extensions) {
            println("isArm64Only ${isArm64Only(project)}")
            if (isArm64Only(project))
                listOf(iosArm64())
            else
                listOf(iosX64(), iosArm64(), iosSimulatorArm64())
        }
}