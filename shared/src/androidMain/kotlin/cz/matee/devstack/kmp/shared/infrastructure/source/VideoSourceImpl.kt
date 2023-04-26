package cz.matee.devstack.kmp.shared.infrastructure.source

import cz.matee.devstack.kmp.shared.data.source.VideoSource
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.infrastructure.local.VideoCompressor
import kotlinx.coroutines.flow.Flow

actual class VideoSourceImpl(
    private val videoCompressor: VideoCompressor,
) : VideoSource {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = videoCompressor.compress(
        inputPath,
        outputPath,
        options,
    )
}
