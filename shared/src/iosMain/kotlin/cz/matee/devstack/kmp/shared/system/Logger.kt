package cz.matee.devstack.kmp.shared.system

import platform.Foundation.NSLog

actual object Log : Logger {

    override fun d(tag: String, message: String) {
        NSLog("${tag}: $message")
    }

    override fun w(tag: String, message: String, throwable: Throwable?) {
        NSLog("${tag}: $message - ${throwable.toString()}")
    }


    override fun e(tag: String, message: String, throwable: Throwable) {
        NSLog("${tag}: $message - $throwable")
    }

}