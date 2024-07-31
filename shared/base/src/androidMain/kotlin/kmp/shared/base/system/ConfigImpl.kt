package kmp.shared.base.system

import kmp.shared.base.BuildConfig

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = BuildConfig.BUILD_TYPE == "release"
}
