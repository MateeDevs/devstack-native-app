package cz.matee.devstack.kmp.shared.data.repository

import cz.matee.devstack.kmp.shared.data.source.VideoSource
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressLibrary
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.domain.repository.VideoRepository
import kotlinx.coroutines.flow.Flow

class VideoRepositoryImpl(
    private val videoSource: VideoSource,
) : VideoRepository {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
    ): Flow<VideoCompressResult> = videoSource.compress(
        inputPath,
        outputPath,
        options,
        library,
    )
}
