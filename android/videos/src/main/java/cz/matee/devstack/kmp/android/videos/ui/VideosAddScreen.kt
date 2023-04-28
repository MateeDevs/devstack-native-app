package cz.matee.devstack.kmp.android.videos.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.systemBarsPadding
import androidx.compose.foundation.layout.wrapContentWidth
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Divider
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import cz.matee.devstack.kmp.android.shared.style.Values
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
        verticalArrangement = Arrangement.spacedBy(Values.Space.medium)
    ) {
        Button(
            onClick = {
                imagePicker.launchGalleryPicker()
            },
            modifier = Modifier
                .fillMaxWidth(),
        ) {
            Text(text = "Pick video")
        }

        CircularProgressIndicator(
            progress = state.progress / 100f,
            modifier = Modifier
                .fillMaxWidth()
                .wrapContentWidth(Alignment.CenterHorizontally),
        )

        LazyColumn(
            verticalArrangement = Arrangement.spacedBy(Values.Space.medium),
        ) {
            items(state.results) { result ->
                Column {
                    Text("Options: ${result.options}")
                    Text("Duration: ${result.durationToCompress}")
                    Text("Ratio: ${result.compressionRation}")
                    Text("Saving: ${result.spaceSaving}")
                    Text("Input: ${result.inputLength.humanReadableByteCountBin()}")
                    Text("Output: ${result.outputLength.humanReadableByteCountBin()}")
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
