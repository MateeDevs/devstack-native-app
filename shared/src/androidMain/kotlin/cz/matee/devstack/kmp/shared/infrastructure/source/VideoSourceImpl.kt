package cz.matee.devstack.kmp.shared.infrastructure.source

import cz.matee.devstack.kmp.shared.data.source.VideoSource
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressLibrary
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.infrastructure.local.VideoCompressor
import kotlinx.coroutines.flow.Flow

actual class VideoSourceImpl(
    private val transcoderVideoCompressor: VideoCompressor,
    private val liTrVideoCompressor: VideoCompressor,
    private val lightCompressorVideoCompressor: VideoCompressor,
) : VideoSource {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
    ): Flow<VideoCompressResult> = when (library) {
        VideoCompressLibrary.Transcoder -> transcoderVideoCompressor
        VideoCompressLibrary.LiTr -> liTrVideoCompressor
        VideoCompressLibrary.LightCompressor -> lightCompressorVideoCompressor
    }.compress(
        inputPath,
        outputPath,
        options,
    )
}
