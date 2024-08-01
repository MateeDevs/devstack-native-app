package kmp.android.videos.vm

import android.app.Application
import android.content.ContentResolver
import android.net.Uri
import android.provider.OpenableColumns
import androidx.lifecycle.viewModelScope
import kmp.android.shared.vm.BaseIntentViewModel
import kmp.android.shared.vm.VmIntent
import kmp.android.shared.vm.VmState
import kmp.shared.base.Result
import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.model.VideoCompressResult
import kmp.shared.domain.usecase.video.CompressVideoUseCase
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileNotFoundException
import java.util.UUID
import kotlin.time.Duration
import kotlin.time.measureTime

data class CompressionResult(
    val options: VideoCompressOptions,
    val library: VideoCompressLibrary,
    val durationToCompress: Duration,
    val inputLength: Long,
    val outputLength: Long,
    val resultUri: String,
) {
    val compressionRation = inputLength.toDouble() / outputLength.toDouble()
    val spaceSaving = 1 - (outputLength.toDouble() / inputLength.toDouble())
}

data class VideosState(
    val results: List<CompressionResult> = emptyList(),
    val didStartProcessing: Boolean = false,
    val progress: Int = 0,
    val currentLibrary: VideoCompressLibrary? = null,
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
                bitrate = 2_500_000,
//                trim = 20.seconds,
//                frameRate = 30,
            ) to VideoCompressLibrary.Transcoder,
            VideoCompressOptions(
                maximumSize = Pair(1920, 1080),
                bitrate = 2_500_000,
//                trim = 20.seconds,
//                frameRate = 30,
            ) to VideoCompressLibrary.LiTr,
            VideoCompressOptions(
                maximumSize = Pair(1920, 1080),
                bitrate = 2_500_000,
//                trim = 20.seconds,
//                frameRate = 30,
            ) to VideoCompressLibrary.LightCompressor,
        )

        state = state.copy(results = emptyList(), didStartProcessing = true)

        viewModelScope.launch(Dispatchers.IO) {
            options.onEach { (option, library) ->
                compressVideo(uri, option, library)
            }
        }
    }

    private suspend fun compressVideo(
        uri: Uri,
        options: VideoCompressOptions,
        library: VideoCompressLibrary,
    ) {
        state = state.copy(progress = 0)
        val directory = context.externalCacheDir ?: return
        var output = "${directory.absolutePath}/${UUID.randomUUID()}$options-${library.name}.mp4"
        val inputLength = uri.length(context.contentResolver)
        val duration = measureTime {
            compressVideoUseCase(
                CompressVideoUseCase.Params(
                    uri.toString(),
                    output,
                    options,
                    library,
                ),
            ).collect { videoCompressResult ->
                state = when (videoCompressResult) {
                    is VideoCompressResult.Completion -> {
                        when (val result = videoCompressResult.result) {
                            is Result.Error -> state.copy(progress = 100)

                            is Result.Success -> {
                                output = result.data
                                state.copy(progress = 100)
                            }
                        }
                    }

                    is VideoCompressResult.Progress -> state.copy(
                        progress = videoCompressResult.progress,
                        currentLibrary = library,
                    )
                }
            }
        }
        state = state.copy(
            results = state.results + CompressionResult(
                durationToCompress = duration,
                options = options,
                inputLength = inputLength,
                outputLength = File(output).length(),
                library = library,
                resultUri = output,
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
