package kmp.shared.core.system

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = true
}
