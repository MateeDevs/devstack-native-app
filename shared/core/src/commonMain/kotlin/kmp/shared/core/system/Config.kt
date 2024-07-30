package kmp.shared.core.system

interface Config {
    val isRelease: Boolean
}

expect class ConfigImpl : Config
