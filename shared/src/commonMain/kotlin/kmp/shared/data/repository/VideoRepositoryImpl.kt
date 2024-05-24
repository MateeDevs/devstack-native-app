package kmp.shared.data.repository

import kmp.shared.data.source.VideoSource
import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kmp.shared.domain.repository.VideoRepository
import kotlinx.coroutines.flow.Flow

internal class VideoRepositoryImpl(
    private val videoSource: VideoSource,
) : VideoRepository {
    override fun compress(
        inputPath: MediaUrlPath,
        outputPath: MediaUrlPath,
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
    ): Flow<VideoCompressResult> = videoSource.compress(
        inputPath,
        outputPath,
        options,
        library,
    )
}
