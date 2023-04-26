package cz.matee.devstack.kmp.shared.infrastructure.local

import android.app.Application
import android.media.MediaFormat
import androidx.core.net.toUri
import com.linkedin.android.litr.MediaTransformer
import com.linkedin.android.litr.TransformationListener
import com.linkedin.android.litr.analytics.TrackTransformationInfo
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow

class LiTrVideoCompressor(
    private val application: Application,
) : VideoCompressor {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        val mediaTransformer = MediaTransformer(application)

        // TODO: Get Uri from path
        mediaTransformer
            .transform(
                "1",
                inputPath.toUri(),
                outputPath,
                MediaFormat.createVideoFormat(
                    "video/mp4",
                    640,
                    480,
                ).also {
//                    it.setInteger(MediaFormat.KEY_BIT_RATE, options.bitrate.toInt())
                },
                null,
                object : TransformationListener {
                    override fun onStarted(id: String) {
                        trySendBlocking(VideoCompressResult.Progress(0))
                    }

                    override fun onProgress(id: String, progress: Float) {
                        trySendBlocking(VideoCompressResult.Progress((progress * 100).toInt()))
                    }

                    override fun onCompleted(
                        id: String,
                        trackTransformationInfos: MutableList<TrackTransformationInfo>?,
                    ) {
                        trySendBlocking(VideoCompressResult.Completion(Result.Success(Unit)))
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
                null,
            )

        awaitClose {
            mediaTransformer.release()
        }
    }
}
