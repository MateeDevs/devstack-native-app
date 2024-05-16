package cz.matee.devstack.kmp.android.videos.ui

import androidx.compose.animation.AnimatedVisibility
import androidx.compose.foundation.border
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Divider
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.videos.vm.CompressionResult
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
        modifier = modifier.systemBarsPadding(),
    ) {
        Button(
            onClick = {
                imagePicker.launchGalleryPicker()
            },
            modifier = Modifier
                .fillMaxWidth()
                .padding(Values.Space.medium),
        ) {
            Text(text = "Pick video")
        }

        AnimatedVisibility(visible = state.progress < 100) {
            CircularProgressIndicator(
                progress = state.progress / 100f,
                modifier = Modifier
                    .fillMaxWidth()
                    .wrapContentWidth(Alignment.CenterHorizontally)
                    .padding(bottom = Values.Space.medium),
            )
        }

        var selected by remember { mutableStateOf<CompressionResult?>(null) }
        VideoPlayer(
            uri = selected?.resultUri,
            modifier = Modifier
                .wrapContentWidth()
                .height(200.dp),
        )

        LazyColumn() {
            items(state.results) { result ->
                Column(
                    modifier = Modifier
                        .clickable { selected = result }
                        .border(
                            2.dp,
                            if (selected == result) MaterialTheme.colors.primary else Color.Transparent
                        ),
                ) {
                    Spacer(modifier = Modifier.height(Values.Space.small))
                    Text("Library: ${result.library.name}")
                    Text("Options: ${result.options}")
                    Text("Duration: ${result.durationToCompress}")
                    Text("Ratio: ${result.compressionRation}")
                    Text("Saving: ${result.spaceSaving}")
                    Text("Input: ${result.inputLength.humanReadableByteCountBin()}")
                    Text("Output: ${result.outputLength.humanReadableByteCountBin()}")
                    Spacer(modifier = Modifier.height(Values.Space.small))
                    Divider()
                }
            }
        }
    }
}

private fun Long.humanReadableByteCountBin() = when {
    this == Long.MIN_VALUE || this < 0 -> "N/A"
    this < 1024L -> "$this B"
    this <= 0xfffccccccccccccL shr 40 -> "%.1f KiB".format(toDouble() / (0x1 shl 10))
    this <= 0xfffccccccccccccL shr 30 -> "%.1f MiB".format(toDouble() / (0x1 shl 20))
    this <= 0xfffccccccccccccL shr 20 -> "%.1f GiB".format(toDouble() / (0x1 shl 30))
    this <= 0xfffccccccccccccL shr 10 -> "%.1f TiB".format(toDouble() / (0x1 shl 40))
    this <= 0xfffccccccccccccL -> "%.1f PiB".format((this shr 10).toDouble() / (0x1 shl 40))
    else -> "%.1f EiB".format((this shr 20).toDouble() / (0x1 shl 40))
}
