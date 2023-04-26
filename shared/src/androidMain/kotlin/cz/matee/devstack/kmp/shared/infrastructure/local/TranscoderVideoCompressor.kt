package cz.matee.devstack.kmp.shared.infrastructure.local

import com.otaliastudios.transcoder.Transcoder
import com.otaliastudios.transcoder.TranscoderListener
import com.otaliastudios.transcoder.strategy.DefaultVideoStrategy
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.error.domain.CommonError
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import kotlinx.coroutines.channels.trySendBlocking
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow

class TranscoderVideoCompressor : VideoCompressor {
    override fun compress(
        inputPath: String,
        outputPath: String,
        options: VideoCompressOptions,
    ): Flow<VideoCompressResult> = callbackFlow {
        Transcoder.into(outputPath)
            .addDataSource(inputPath)
            .setVideoTrackStrategy(
                DefaultVideoStrategy.Builder()
                    .bitRate(options.bitrate).build(),
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
    }
}