package cz.matee.devstack.kmp.shared.infrastructure.local

import android.app.Application
import androidx.core.net.toUri
import com.otaliastudios.transcoder.Transcoder
import com.otaliastudios.transcoder.TranscoderListener
import com.otaliastudios.transcoder.TranscoderOptions
import com.otaliastudios.transcoder.resize.AtMostResizer
import com.otaliastudios.transcoder.source.DataSource
import com.otaliastudios.transcoder.source.TrimDataSource
import com.otaliastudios.transcoder.source.UriDataSource
import com.otaliastudios.transcoder.strategy.DefaultVideoStrategy
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.system.Log
import kotlinx.coroutines.channels.ProducerScope
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
        val uriDataSource = UriDataSource(application, inputPath.toUri())
        Transcoder.into(outputPath)
            .applyTrim(options, uriDataSource)
            .setVideoTrackStrategy(
                DefaultVideoStrategy.Builder()
                    .applyBitrate(options)
                    .applyFrameRate(options)
                    .applyMaximumSize(options)
                    .build(),
            )
            .setListener(flowListener)
            .transcode()
        awaitClose()
    }

    private fun TranscoderOptions.Builder.applyTrim(
        options: VideoCompressOptions,
        dataSource: DataSource,
    ) = apply {
        options.trim?.let {
            dataSource.initialize()
            val maxDuration = dataSource.durationUs
            addDataSource(
                TrimDataSource(
                    dataSource,
                    0,
                    (maxDuration - options.trim.inWholeMicroseconds)
                        .coerceAtLeast(0),
                ),
            )
        } ?: addDataSource(dataSource)
    }

    private fun DefaultVideoStrategy.Builder.applyBitrate(options: VideoCompressOptions) =
        apply { options.bitrate?.let(::bitRate) }

    private fun DefaultVideoStrategy.Builder.applyFrameRate(options: VideoCompressOptions) =
        apply { options.frameRate?.let(::frameRate) }

    private fun DefaultVideoStrategy.Builder.applyMaximumSize(options: VideoCompressOptions) =
        apply {
            options.maximumSize?.let { (first, second) ->
                val major = maxOf(first, second)
                val minor = minOf(first, second)
                addResizer(AtMostResizer(minor, major))
            }
        }

    private val ProducerScope<VideoCompressResult>.flowListener
        get() = object : TranscoderListener {
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
        }
}
