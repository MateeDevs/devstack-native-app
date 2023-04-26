package cz.matee.devstack.kmp.shared.domain.repository

import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.flow.Flow

interface VideoRepository {
    fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult>
}
