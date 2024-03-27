package kmp.shared.base.error

import dev.icerock.moko.resources.desc.StringDesc
import kmp.shared.base.ErrorResult
import kotlin.experimental.ExperimentalObjCName

internal class ErrorMessageProviderImpl : ErrorMessageProvider() {
    override fun StringDesc.toMessageString(): String = localized()
}

@OptIn(ExperimentalObjCName::class)
fun ErrorResult.localizedMessage(@ObjCName(swiftName = "_") defMessage: String? = null): String {
    return ErrorMessageProviderImpl().getMessage(this, defMessage)
}
