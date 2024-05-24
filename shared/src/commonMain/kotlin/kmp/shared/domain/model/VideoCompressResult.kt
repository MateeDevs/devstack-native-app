package kmp.shared.domain.model

import kmp.shared.base.Result

sealed interface VideoCompressResult {
    data class Progress(val progress: Int) : VideoCompressResult
    data class Completion(val result: Result<MediaUrlPath>) : VideoCompressResult
}
