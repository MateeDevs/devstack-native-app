package kmp.shared.base.system

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = true
}
