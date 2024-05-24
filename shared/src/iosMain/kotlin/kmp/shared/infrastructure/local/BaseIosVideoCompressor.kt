package kmp.shared.infrastructure.local

import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow

class BaseIosVideoCompressor(
    val callback: (BaseIosVideoCompressorParams) -> Unit,
) : VideoCompressor {

    override fun compress(
        inputPath: MediaUrlPath,
        outputPath: MediaUrlPath,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        val params = BaseIosVideoCompressorParams(inputPath, outputPath, options) { result ->
            trySend(result)
            if (result is VideoCompressResult.Completion) {
                close()
            }
        }
        callback(params)
        awaitClose()
    }
}

data class BaseIosVideoCompressorParams(
    val inputPath: MediaUrlPath,
    val outputPath: MediaUrlPath,
    val options: VideoCompressOptions,
    val callback: ((VideoCompressResult) -> Unit),
)
