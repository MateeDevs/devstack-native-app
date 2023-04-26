package cz.matee.devstack.kmp.shared.infrastructure.local

import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.flow.Flow

interface VideoCompressor {
    fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult>
}
