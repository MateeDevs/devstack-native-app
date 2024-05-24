package kmp.shared.infrastructure.local

import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.flow.Flow

interface VideoCompressor {
    fun compress(
        inputPath: MediaUrlPath,
        outputPath: MediaUrlPath,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult>
}
