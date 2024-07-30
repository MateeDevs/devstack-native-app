package kmp.shared.core.system

import kmp.shared.core.BuildConfig

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = BuildConfig.BUILD_TYPE == "release"
}
