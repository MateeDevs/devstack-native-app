package cz.matee.devstack.kmp.shared.infrastructure.local

import android.app.Application
import androidx.core.net.toUri
import com.abedelazizshe.lightcompressorlibrary.CompressionListener
import com.abedelazizshe.lightcompressorlibrary.VideoQuality
import com.abedelazizshe.lightcompressorlibrary.config.AppSpecificStorageConfiguration
import com.abedelazizshe.lightcompressorlibrary.config.Configuration
import com.abedelazizshe.lightcompressorlibrary.config.SaveLocation
import com.abedelazizshe.lightcompressorlibrary.config.SharedStorageConfiguration
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow

class LightCompressorVideoCompressor(
    private val application: Application,
) : VideoCompressor {

    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        com.abedelazizshe.lightcompressorlibrary.VideoCompressor.start(
            context = application,
            uris = listOf(inputPath.toUri()),
            isStreamable = false,
            appSpecificStorageConfiguration = AppSpecificStorageConfiguration(
                subFolderName = null,
            ),
            configureWith = Configuration(
                videoNames = listOf(outputPath.split("/").last()),
                quality = VideoQuality.MEDIUM,
                isMinBitrateCheckEnabled = false,
                videoBitrateInMbps = options.bitrate?.div(1_000_000)?.toInt(),
                disableAudio = false,
                keepOriginalResolution = options.maximumSize == null,
                videoWidth = options.maximumSize?.first?.toDouble(),
                videoHeight = options.maximumSize?.second?.toDouble(),
            ),
            listener = object : CompressionListener {
                override fun onProgress(index: Int, percent: Float) {
                    // Update UI with progress value
                    trySendBlocking(VideoCompressResult.Progress(percent.toInt()))
                }

                override fun onStart(index: Int) {
                    // Compression start
                }

                override fun onSuccess(index: Int, size: Long, path: String?) {
                    // On Compression success
                    trySendBlocking(VideoCompressResult.Completion(Result.Success(path ?: outputPath)))
                    close()
                }

                override fun onFailure(index: Int, failureMessage: String) {
                    // On Failure
                    trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                    close()
                }

                override fun onCancelled(index: Int) {
                    // On Cancelled
                    trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                    close()
                }

            },
        )
        awaitClose()
    }
}