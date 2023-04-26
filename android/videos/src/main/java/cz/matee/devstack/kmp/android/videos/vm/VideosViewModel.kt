package cz.matee.devstack.kmp.android.videos.vm

import android.app.Application
import android.net.Uri
import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.android.shared.vm.BaseIntentViewModel
import cz.matee.devstack.kmp.android.shared.vm.VmIntent
import cz.matee.devstack.kmp.android.shared.vm.VmState
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.domain.model.default
import cz.matee.devstack.kmp.shared.domain.usecase.video.CompressVideoUseCase
import cz.matee.devstack.kmp.shared.system.Log
import kotlinx.coroutines.launch
import java.util.UUID
import kotlin.time.Duration
import kotlin.time.ExperimentalTime
import kotlin.time.measureTime

data class VideosState(
    val progress: Int = 0,
    val complete: Boolean = false,
    val durationToCompress: Duration = Duration.ZERO,
    val error: ErrorResult? = null,
) : VmState

class VideosViewModel(
    private val context: Application,
    private val compressVideoUseCase: CompressVideoUseCase,
) : BaseIntentViewModel<VideosState, VideosIntent>(VideosState()) {

    override suspend fun applyIntent(intent: VideosIntent) = when (intent) {
        is VideosIntent.VideoPicked -> compressVideo(intent.uri)
    }

    @OptIn(ExperimentalTime::class)
    private suspend fun compressVideo(uri: Uri) {
        viewModelScope.launch {
            state = VideosState()
            val directory = context.externalCacheDir ?: return@launch
            val output = "${directory.absolutePath}/${UUID.randomUUID()}.mp4"
            val duration = measureTime {
                compressVideoUseCase(
                    CompressVideoUseCase.Params(
                        uri.toString(),
                        output,
                        VideoCompressOptions.default(),
                    ),
                ).collect { result ->
                    state = when (result) {
                        is VideoCompressResult.Completion -> {
                            when (result.result) {
                                is Result.Error -> state.copy(error = (result.result as Result.Error<Unit>).error)
                                is Result.Success -> state.copy(complete = true)
                            }
                        }

                        is VideoCompressResult.Progress -> state.copy(progress = result.progress)
                    }
                }
            }
            state = state.copy(durationToCompress = duration)
        }
    }
}

sealed interface VideosIntent : VmIntent {
    data class VideoPicked(val uri: Uri) : VideosIntent
}
