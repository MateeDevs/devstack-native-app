package cz.matee.devstack.kmp.shared.system

actual class ConfigImpl : Config {
    override val isRelease: Boolean
        get() = true
}