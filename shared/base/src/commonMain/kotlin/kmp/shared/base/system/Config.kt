package kmp.shared.base.system

interface Config {
    val isRelease: Boolean
}

expect class ConfigImpl : Config
