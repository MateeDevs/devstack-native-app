package cz.matee.devstack.kmp.shared.infrastructure.local

import android.content.Context
import android.media.MediaFormat
import android.net.Uri
import com.linkedin.android.litr.MediaTransformer
import com.linkedin.android.litr.TransformationListener
import com.linkedin.android.litr.analytics.TrackTransformationInfo
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import java.util.UUID

class LiTrVideoCompressor(
    private val context: Context,
) : VideoCompressor {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        val mediaTransformer = MediaTransformer(context)

        // TODO: Get Uri from path
        mediaTransformer
            .transform(
                UUID.randomUUID().toString(),
                Uri.parse(inputPath),
                outputPath,
                MediaFormat()
                    .also {
                          it.setInteger(MediaFormat.KEY_BIT_RATE, options.bitrate.toInt())
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
                        mediaTransformer.release()
                        close()
                    }

                    override fun onCancelled(
                        id: String,
                        trackTransformationInfos: MutableList<TrackTransformationInfo>?,
                    ) {
                        trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                        mediaTransformer.release()
                        close()
                    }

                    override fun onError(
                        id: String,
                        cause: Throwable?,
                        trackTransformationInfos: MutableList<TrackTransformationInfo>?,
                    ) {
                        trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                        mediaTransformer.release()
                        close()
                    }
                },
                null,
            )
    }
}