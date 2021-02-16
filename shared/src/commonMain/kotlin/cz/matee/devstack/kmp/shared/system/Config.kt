package cz.matee.devstack.kmp.shared.system

interface Config {
    val isRelease: Boolean
}

expect class ConfigImpl : Config