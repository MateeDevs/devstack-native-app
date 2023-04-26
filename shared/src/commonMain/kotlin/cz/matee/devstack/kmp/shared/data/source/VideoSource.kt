package cz.matee.devstack.kmp.shared.data.source

import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.flow.Flow

interface VideoSource {
    fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult>
}