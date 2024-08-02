package kmp.android.samplesharedviewmodel.ui

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
import kmp.android.samplesharedviewmodel.navigation.SampleSharedViewModelGraph
import kmp.android.shared.navigation.composableDestination
import kmp.android.shared.style.Values
import kmp.shared.samplesharedviewmodel.vm.SampleSharedEvent
import kmp.shared.samplesharedviewmodel.vm.SampleSharedIntent
import kmp.shared.samplesharedviewmodel.vm.SampleSharedState
import kmp.shared.samplesharedviewmodel.vm.SampleSharedViewModel
import kotlinx.coroutines.flow.collectLatest
import org.koin.androidx.compose.getViewModel

internal fun NavGraphBuilder.sampleSharedViewModelMainRoute() {
    composableDestination(
        destination = SampleSharedViewModelGraph.Main,
    ) {
        SampleSharedViewModelMainRoute()
    }
}

@Composable
internal fun SampleSharedViewModelMainRoute(
    viewModel: SampleSharedViewModel = getViewModel(),
) {
    val state by viewModel.state.collectAsStateWithLifecycle()

    LaunchedEffect(key1 = viewModel) {
        viewModel.onIntent(SampleSharedIntent.OnAppeared)
    }

    val context = LocalContext.current
    LaunchedEffect(key1 = viewModel) {
        viewModel.events.collectLatest { event ->
            when (event) {
                is SampleSharedEvent.ShowMessage -> Toast.makeText(
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
    state: SampleSharedState,
    onIntent: (SampleSharedIntent) -> Unit,
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
                        text = "This is a sample with android compose UI and shared VM",
                        textAlign = TextAlign.Center,
                    )
                    Text(text = state.sampleText?.value ?: "")
                    Button(onClick = { onIntent(SampleSharedIntent.OnButtonTapped) }) {
                        Text(text = "Click me!")
                    }
                }
            }
        }
    }
}
