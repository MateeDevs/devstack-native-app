package kmp.shared.base.system

import platform.Foundation.NSLog

actual object Log : Logger {

    override fun d(tag: String, message: String) {
        NSLog("$tag: $message")
    }

    override fun w(tag: String, message: String, throwable: Throwable?) {
        NSLog("$tag: $message - $throwable")
    }

    override fun e(tag: String, message: String, throwable: Throwable) {
        NSLog("$tag: $message - $throwable")
    }
}
