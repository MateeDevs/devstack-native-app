package kmp.shared.base.error

import android.content.Context
import dev.icerock.moko.resources.desc.StringDesc

internal class ErrorMessageProviderImpl(private val context: Context) : ErrorMessageProvider() {
    override fun StringDesc.toMessageString(): String = toString(context)
}
