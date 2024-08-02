package kmp.android.sample.ui

import android.widget.Toast
import androidx.compose.animation.AnimatedContent
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.style.TextAlign
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavGraphBuilder
import kmp.android.sample.navigation.SampleGraph
import kmp.android.sample.vm.SampleEvent
import kmp.android.sample.vm.SampleIntent
import kmp.android.sample.vm.SampleState
import kmp.android.sample.vm.SampleViewModel
import kmp.android.shared.navigation.composableDestination
import kmp.android.shared.style.Values
import kotlinx.coroutines.flow.collectLatest
import org.koin.androidx.compose.getViewModel

internal fun NavGraphBuilder.sampleMainRoute() {
    composableDestination(
        destination = SampleGraph.Main,
    ) {
        SampleMainRoute()
    }
}

@Composable
internal fun SampleMainRoute(
    viewModel: SampleViewModel = getViewModel(),
) {
    val state by viewModel.state.collectAsStateWithLifecycle()

    LaunchedEffect(key1 = viewModel) {
        viewModel.onIntent(SampleIntent.OnAppeared)
    }

    val context = LocalContext.current
    LaunchedEffect(key1 = viewModel) {
        viewModel.events.collectLatest { event ->
            when (event) {
                is SampleEvent.ShowMessage -> Toast.makeText(
                    context,
                    event.message,
                    Toast.LENGTH_SHORT,
                ).show()
            }
        }
    }

    SampleMainScreen(
        state = state,
        onIntent = { viewModel.onIntent(it) },
    )
}

@Composable
private fun SampleMainScreen(
    state: SampleState,
    onIntent: (SampleIntent) -> Unit,
) {
    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
        AnimatedContent(targetState = state.loading, label = "AnimatedLoading") { loading ->
            if (loading) {
                CircularProgressIndicator()
            } else {
                Column(
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.spacedBy(Values.Space.medium),
                    modifier = Modifier.padding(Values.Space.medium),
                ) {
                    Text(
                        text = "This is a sample with android compose UI and android VM",
                        textAlign = TextAlign.Center,
                    )
                    Text(text = state.sampleText?.value ?: "")
                    Button(onClick = { onIntent(SampleIntent.OnButtonTapped) }) {
                        Text(text = "Click me!")
                    }
                }
            }
        }
    }
}
