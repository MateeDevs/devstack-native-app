package cz.matee.devstack.kmp.shared.infrastructure.local

import android.app.Application
import android.media.MediaFormat
import androidx.core.net.toUri
import com.linkedin.android.litr.MediaTransformer
import com.linkedin.android.litr.TransformationListener
import com.linkedin.android.litr.TransformationOptions
import com.linkedin.android.litr.analytics.TrackTransformationInfo
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import java.util.UUID

class LiTrVideoCompressor(
    private val application: Application,
) : VideoCompressor {

    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        val mediaTransformer = MediaTransformer(application)

        val targetVideoFormat = MediaFormat()
        targetVideoFormat.setString(MediaFormat.KEY_MIME, "video/avc")
        options.maximumSize?.let { (width, height) ->
            targetVideoFormat.setInteger(MediaFormat.KEY_WIDTH, width)
            targetVideoFormat.setInteger(MediaFormat.KEY_HEIGHT, height)
        }
        options.bitrate?.let { bitrate ->
            targetVideoFormat.setInteger(MediaFormat.KEY_BIT_RATE, bitrate.toInt())
        }
        targetVideoFormat.setInteger(MediaFormat.KEY_I_FRAME_INTERVAL, 5)
        options.frameRate?.let { frameRate ->
            targetVideoFormat.setInteger(MediaFormat.KEY_FRAME_RATE, frameRate)
        }

        mediaTransformer.transform(
            UUID.randomUUID().toString(),
            inputPath.toUri(),
            outputPath,
            targetVideoFormat,
            null, // do not change audio format
            object : TransformationListener {
                override fun onStarted(id: String) {
                    // Do nothing
                }

                override fun onProgress(id: String, progress: Float) {
                    trySendBlocking(VideoCompressResult.Progress((progress * 100).toInt()))
                }

                override fun onCompleted(
                    id: String,
                    trackTransformationInfos: MutableList<TrackTransformationInfo>?,
                ) {
                    trySendBlocking(VideoCompressResult.Completion(Result.Success(outputPath)))
                    close()
                }

                override fun onCancelled(
                    id: String,
                    trackTransformationInfos: MutableList<TrackTransformationInfo>?,
                ) {
                    trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                    close()
                }

                override fun onError(
                    id: String,
                    cause: Throwable?,
                    trackTransformationInfos: MutableList<TrackTransformationInfo>?,
                ) {
                    trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                    close()
                }

            },
            TransformationOptions.Builder().build(),
        )
        awaitClose()
        mediaTransformer.release()
    }
}