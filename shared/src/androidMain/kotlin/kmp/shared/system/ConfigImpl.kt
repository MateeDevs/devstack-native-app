package kmp.shared.system

import kmp.shared.BuildConfig

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = BuildConfig.BUILD_TYPE == "release"
}
