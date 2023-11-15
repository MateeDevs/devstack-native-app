package kmp.shared.system

import kmp.shared.system.Config

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = true
}
