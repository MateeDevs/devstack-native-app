package kmp.shared.core.system

interface Logger {
    fun d(tag: String, message: String)
    fun w(tag: String, message: String, throwable: Throwable?)
    fun e(tag: String, message: String, throwable: Throwable)
}

expect object Log : Logger
