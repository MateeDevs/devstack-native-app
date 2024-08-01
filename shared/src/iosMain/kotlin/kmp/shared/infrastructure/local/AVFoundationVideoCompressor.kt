package kmp.shared.infrastructure.local

import kmp.shared.base.Result
import kmp.shared.base.error.domain.CommonError
import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.launch
import platform.AVFoundation.AVAssetExportPreset1280x720
import platform.AVFoundation.AVAssetExportPreset1920x1080
import platform.AVFoundation.AVAssetExportPreset640x480
import platform.AVFoundation.AVAssetExportPreset960x540
import platform.AVFoundation.AVAssetExportPresetMediumQuality
import platform.AVFoundation.AVAssetExportSession
import platform.AVFoundation.AVAssetExportSessionStatusCancelled
import platform.AVFoundation.AVAssetExportSessionStatusCompleted
import platform.AVFoundation.AVAssetExportSessionStatusExporting
import platform.AVFoundation.AVAssetExportSessionStatusFailed
import platform.AVFoundation.AVAssetExportSessionStatusUnknown
import platform.AVFoundation.AVAssetExportSessionStatusWaiting
import platform.AVFoundation.AVFileTypeMPEG4
import platform.AVFoundation.AVURLAsset
import platform.Foundation.NSURL
import kotlin.coroutines.EmptyCoroutineContext

internal class AVFoundationVideoCompressor : VideoCompressor {

    override fun compress(
        inputPath: MediaUrlPath,
        outputPath: MediaUrlPath,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        compressVideo(
            inputURL = inputPath,
            outputURL = outputPath,
            exportPreset = options.maximumSize?.let { (width, height) ->
                when {
                    width == 640 && height == 480 -> AVAssetExportPreset640x480
                    width == 960 && height == 540 -> AVAssetExportPreset960x540
                    width == 1280 && height == 720 -> AVAssetExportPreset1280x720
                    width == 1920 && height == 1080 -> AVAssetExportPreset1920x1080
                    else -> AVAssetExportPresetMediumQuality
                }
            } ?: AVAssetExportPresetMediumQuality,
            progress = {
                trySendBlocking(
                    VideoCompressResult.Progress(
                        VideoCompressLibrary.AVFoundation,
                        (it * 100).toInt(),
                    ),
                )
            },
        ) { session ->
            when (session.status) {
                AVAssetExportSessionStatusWaiting -> {}

                AVAssetExportSessionStatusExporting -> {}

                AVAssetExportSessionStatusCompleted -> {
                    trySendBlocking(VideoCompressResult.Completion(Result.Success(outputPath)))
                    close()
                }

                AVAssetExportSessionStatusCancelled -> {
                    trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                    close()
                }

                AVAssetExportSessionStatusFailed -> {
                    trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                    close()
                }

                AVAssetExportSessionStatusUnknown -> {}
            }
        }
        awaitClose()
    }

    private fun compressVideo(
        inputURL: NSURL,
        outputURL: NSURL,
        exportPreset: String,
        progress: (Float) -> Unit,
        handler: (AVAssetExportSession) -> Unit,
    ) {
        val urlAsset = AVURLAsset(uRL = inputURL, options = null)
        val exportSession = AVAssetExportSession(
            asset = urlAsset,
            presetName = exportPreset,
        )

        val timer = CoroutineScope(EmptyCoroutineContext).launch {
            while (true) {
                progress(exportSession.progress)
                delay(100)
            }
        }

        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileTypeMPEG4
        exportSession.exportAsynchronouslyWithCompletionHandler {
            if (exportSession.status in listOf(
                    AVAssetExportSessionStatusCompleted,
                    AVAssetExportSessionStatusCancelled,
                    AVAssetExportSessionStatusFailed,
                )
            ) {
                progress(exportSession.progress)
                timer.cancel()
            }
            handler(exportSession)
        }
    }
}