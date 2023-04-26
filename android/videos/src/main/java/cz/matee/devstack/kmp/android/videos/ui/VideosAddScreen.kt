package cz.matee.devstack.kmp.android.videos.ui

import androidx.compose.animation.Crossfade
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.material.Button
import androidx.compose.material.LinearProgressIndicator
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import cz.matee.devstack.kmp.android.videos.vm.VideosIntent
import cz.matee.devstack.kmp.android.videos.vm.VideosViewModel
import org.koin.androidx.compose.koinViewModel

@Composable
fun VideosAddScreen(
    modifier: Modifier = Modifier,
    viewModel: VideosViewModel = koinViewModel(),
) {
    val state = viewModel.state
    val imagePicker = rememberVideoPickerState {
        if (it != null) {
            viewModel.onIntent(VideosIntent.VideoPicked(it))
        }
    }

    Column(
        modifier = modifier
            .systemBarsPadding(),
    ) {
        Crossfade(state) { videosState ->
            if (videosState.complete) {
                Text(text = "Done, took ${videosState.durationToCompress}")
            } else if (videosState.error != null) {
                Text(text = videosState.error.message ?: videosState.error.throwable?.message ?: "Error")
            } else {
                LinearProgressIndicator(
                    progress = videosState.progress / 100f,
                    modifier = Modifier.fillMaxWidth(),
                )
            }
        }

        Button(
            onClick = {
                imagePicker.launchGalleryPicker()
            },
        ) {
            Text(text = "Pick video")
        }
    }
}
