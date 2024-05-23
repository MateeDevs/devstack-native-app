package kmp.shared.infrastructure.source

import kmp.shared.data.source.VideoSource
import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kmp.shared.infrastructure.local.VideoCompressor
import kotlinx.coroutines.flow.Flow

internal class VideoSourceImpl(
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
    }.compress(inputPath, outputPath, options)
}
