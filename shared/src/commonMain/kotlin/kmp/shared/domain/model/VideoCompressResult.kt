package cz.matee.devstack.kmp.shared.domain.model

import cz.matee.devstack.kmp.shared.base.Result

sealed interface VideoCompressResult {
    data class Progress(val progress: Int) : VideoCompressResult
    data class Completion(val result: Result<String>) : VideoCompressResult
}
