package kmp.shared.core.base.error

import dev.icerock.moko.resources.desc.StringDesc
import kmp.shared.core.base.ErrorResult
import kmp.shared.core.base.error.ErrorMessageProvider
import kmp.shared.core.base.error.getMessage
import kotlin.experimental.ExperimentalObjCName

internal class ErrorMessageProviderImpl : ErrorMessageProvider() {
    override fun StringDesc.toMessageString(): String = localized()
}

@OptIn(ExperimentalObjCName::class)
fun ErrorResult.localizedMessage(@ObjCName(swiftName = "_") defMessage: String? = null): String {
    return ErrorMessageProviderImpl().getMessage(this, defMessage)
}
