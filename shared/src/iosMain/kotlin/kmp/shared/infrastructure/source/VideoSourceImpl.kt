package kmp.shared.infrastructure.source

import kmp.shared.data.source.VideoSource
import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kmp.shared.infrastructure.local.VideoCompressor
import kotlinx.coroutines.flow.Flow

internal class VideoSourceImpl(
    private val aVFoundationVideoCompressor: VideoCompressor,
    private val lightCompressorVideoCompressor: VideoCompressor,
) : VideoSource {
    override fun compress(
        inputPath: MediaUrlPath,
        outputPath: MediaUrlPath,
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
    ): Flow<VideoCompressResult> =
        when (library) {
            VideoCompressLibrary.AVFoundation -> aVFoundationVideoCompressor
            VideoCompressLibrary.LightCompressor -> lightCompressorVideoCompressor
        }.compress(
            inputPath = inputPath,
            outputPath = outputPath,
            options = options,
        )
}
