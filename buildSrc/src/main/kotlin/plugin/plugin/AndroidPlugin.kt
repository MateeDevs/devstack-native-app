package plugin.plugin

import org.gradle.kotlin.dsl.apply
import plugin.config.AndroidBuild
import plugin.config.AndroidPresentation
import plugin.config.Coroutines
import plugin.config.Koin
import plugin.config.Compiler


class AndroidLibraryPlugin : BasePlugin({
    apply<AndroidBuild>()
    apply<AndroidPresentation>()
    apply<Compiler>()
    apply<Coroutines>()
    apply<Koin>()
})


class AndroidAppPlugin : BasePlugin({
    apply<AndroidBuild>()
    apply<Compiler>()
    apply<Coroutines>()
    apply<Koin>()
})

