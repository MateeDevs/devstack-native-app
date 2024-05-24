package kmp.shared.domain.repository

import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.flow.Flow

interface VideoRepository {
    fun compress(
        inputPath: MediaUrlPath,
        outputPath: MediaUrlPath,
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
    ): Flow<VideoCompressResult>
}
