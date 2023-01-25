package plugin

import org.gradle.kotlin.dsl.apply
import plugin.config.*


class AndroidLibraryPlugin : BasePlugin({
    apply<AndroidBuild>()
    apply<AndroidPresentation>()
    apply<Compiler>()
    apply<Coroutines>()
    apply<Koin>()
    apply<AndroidLogging>()
})


class AndroidAppPlugin : BasePlugin({
    apply<AndroidBuild>()
    apply<Compiler>()
    apply<Coroutines>()
    apply<Koin>()
})

