package kmp.shared.system

interface Config {
    val isRelease: Boolean
}

expect class ConfigImpl : Config
