package cz.matee.devstack.kmp.android.videos.vm

import android.app.Application
import android.content.ContentResolver
import android.net.Uri
import android.provider.OpenableColumns
import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.android.shared.vm.BaseIntentViewModel
import cz.matee.devstack.kmp.android.shared.vm.VmIntent
import cz.matee.devstack.kmp.android.shared.vm.VmState
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.domain.usecase.video.CompressVideoUseCase
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileNotFoundException
import java.util.UUID
import kotlin.time.Duration
import kotlin.time.Duration.Companion.seconds
import kotlin.time.ExperimentalTime
import kotlin.time.measureTime

data class CompressionResult(
    val options: VideoCompressOptions,
    val durationToCompress: Duration,
    val inputLength: Long,
    val outputLength: Long,
) {
    val compressionRation = inputLength.toDouble() / outputLength.toDouble()
    val spaceSaving = 1 - (outputLength.toDouble() / inputLength.toDouble())
}

data class VideosState(
    val results: List<CompressionResult> = emptyList(),
    val progress: Int = 0,
) : VmState

class VideosViewModel(
    private val context: Application,
    private val compressVideoUseCase: CompressVideoUseCase,
) : BaseIntentViewModel<VideosState, VideosIntent>(VideosState()) {

    override suspend fun applyIntent(intent: VideosIntent) = when (intent) {
        is VideosIntent.VideoPicked -> startBenchmark(intent.uri)
    }

    private suspend fun startBenchmark(
        uri: Uri,
    ) {
        val options = listOf(
            VideoCompressOptions(
                maximumSize = Pair(1920, 1080),
                bitrate = 3_500_000,
                trim = 20.seconds,
                frameRate = 30,
            ),
            VideoCompressOptions(
                maximumSize = Pair(1920, 1080),
                bitrate = 3_000_000,
                trim = 20.seconds,
                frameRate = 30,
            ),
            VideoCompressOptions(
                maximumSize = Pair(1920, 1080),
                bitrate = 2_500_000,
                trim = 20.seconds,
                frameRate = 30,
            ),
        )

        state = state.copy(results = emptyList())

        viewModelScope.launch(Dispatchers.IO) {
            options.onEach { option ->
                compressVideo(uri, option)
            }


        }
    }

    @OptIn(ExperimentalTime::class)
    private suspend fun compressVideo(
        uri: Uri,
        options: VideoCompressOptions,
    ) {
        state = state.copy(progress = 0)
        val directory = context.externalCacheDir ?: return
        val output = "${directory.absolutePath}/${UUID.randomUUID()}$options.mp4"
        val inputLength = uri.length(context.contentResolver)
        val duration = measureTime {
            compressVideoUseCase(
                CompressVideoUseCase.Params(
                    uri.toString(),
                    output,
                    options,
                ),
            ).collect { result ->
                state = when (result) {
                    is VideoCompressResult.Completion -> {
                        when (result.result) {
                            is Result.Error -> state
                            is Result.Success -> state
                        }
                    }

                    is VideoCompressResult.Progress -> state.copy(progress = result.progress)
                }
            }
        }
        state = state.copy(
            results = state.results + CompressionResult(
                durationToCompress = duration,
                options = options,
                inputLength = inputLength,
                outputLength = File(output).length(),
            ),
        )
    }

    private fun Uri.length(contentResolver: ContentResolver)
        : Long {

        val assetFileDescriptor = try {
            contentResolver.openAssetFileDescriptor(this, "r")
        } catch (e: FileNotFoundException) {
            null
        }
        // uses ParcelFileDescriptor#getStatSize underneath if failed
        val length = assetFileDescriptor?.use { it.length } ?: -1L
        if (length != -1L) {
            return length
        }

        // if "content://" uri scheme, try contentResolver table
        if (scheme.equals(ContentResolver.SCHEME_CONTENT)) {
            return contentResolver.query(this, arrayOf(OpenableColumns.SIZE), null, null, null)
                ?.use { cursor ->
                    // maybe shouldn't trust ContentResolver for size: https://stackoverflow.com/questions/48302972/content-resolver-returns-wrong-size
                    val sizeIndex = cursor.getColumnIndex(OpenableColumns.SIZE)
                    if (sizeIndex == -1) {
                        return@use -1L
                    }
                    cursor.moveToFirst()
                    return try {
                        cursor.getLong(sizeIndex)
                    } catch (_: Throwable) {
                        -1L
                    }
                } ?: -1L
        } else {
            return -1L
        }
    }
}

sealed interface VideosIntent : VmIntent {
    data class VideoPicked(val uri: Uri) : VideosIntent
}
