package cz.matee.devstack.kmp.shared.system

import cz.matee.devstack.shared.BuildConfig

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = BuildConfig.BUILD_TYPE == "release"
}
