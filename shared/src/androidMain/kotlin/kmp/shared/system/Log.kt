package kmp.shared.system

import android.util.Log as AndroidLog

actual object Log : Logger {

    override fun d(tag: String, message: String) {
        AndroidLog.d(tag, message)
    }

    override fun w(tag: String, message: String, throwable: Throwable?) {
        AndroidLog.w(tag, message, throwable)
    }

    override fun e(tag: String, message: String, throwable: Throwable) {
        AndroidLog.e(tag, message, throwable)
    }
}
