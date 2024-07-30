package kmp.shared.core.base.error

import android.content.Context
import dev.icerock.moko.resources.desc.StringDesc
import kmp.shared.core.base.error.ErrorMessageProvider

internal class ErrorMessageProviderImpl(private val context: Context) : ErrorMessageProvider() {
    override fun StringDesc.toMessageString(): String = toString(context)
}
