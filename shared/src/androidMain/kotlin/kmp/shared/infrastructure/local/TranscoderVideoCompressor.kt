package cz.matee.devstack.kmp.shared.infrastructure.local

import android.app.Application
import androidx.core.net.toUri
import com.otaliastudios.transcoder.Transcoder
import com.otaliastudios.transcoder.TranscoderListener
import com.otaliastudios.transcoder.resize.AtMostResizer
import com.otaliastudios.transcoder.source.TrimDataSource
import com.otaliastudios.transcoder.source.UriDataSource
import com.otaliastudios.transcoder.strategy.DefaultVideoStrategy
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.system.Log
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow

class TranscoderVideoCompressor(
    private val application: Application,
) : VideoCompressor {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        Log.d("TranscoderVideoCompressor", "Compressing $inputPath to $outputPath using $options")
        val uriDatasource = UriDataSource(application, inputPath.toUri())
        Transcoder.into(outputPath)
            .also { builder ->
                if (options.trimStart != null) {
//                    val maxDuration = uriDatasource.durationUs
                    builder.addDataSource(
                        TrimDataSource(
                            uriDatasource,
                            options.trimStart.inWholeMicroseconds,
                        ),
                    )
                } else {
                    builder.addDataSource(uriDatasource)
                }
            }
            .setVideoTrackStrategy(
                DefaultVideoStrategy.Builder()
                    .also { builder ->
                        if (options.bitrate != null) {
                            builder.bitRate(options.bitrate)
                        }
                        if (options.frameRate != null) {
                            builder.frameRate(options.frameRate)
                        }
                        if (options.maximumSize != null) {
                            builder.addResizer(
                                AtMostResizer(
                                    options.maximumSize.first,
                                    options.maximumSize.second,
                                ),
                            )
                        }
                    }
                    .build(),
            )
            .setListener(
                object : TranscoderListener {
                    override fun onTranscodeProgress(progress: Double) {
                        trySendBlocking(VideoCompressResult.Progress((progress * 100).toInt()))
                    }

                    override fun onTranscodeCompleted(successCode: Int) {
                        trySendBlocking(VideoCompressResult.Completion(Result.Success(Unit)))
                        close()
                    }

                    override fun onTranscodeCanceled() {
                        trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                        close()
                    }

                    override fun onTranscodeFailed(exception: Throwable) {
                        trySendBlocking(VideoCompressResult.Completion(Result.Error(CommonError.UnknownError)))
                        close()
                    }
                },
            )
            .transcode()
        awaitClose()
    }
}