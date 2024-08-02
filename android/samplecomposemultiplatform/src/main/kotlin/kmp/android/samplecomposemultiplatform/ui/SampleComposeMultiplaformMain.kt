package kmp.android.samplecomposemultiplatform.ui

import android.widget.Toast
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavGraphBuilder
import kmp.android.samplecomposemultiplatform.navigation.SampleComposeMultiplatformGraph
import kmp.android.shared.navigation.composableDestination
import kmp.shared.samplecomposemultiplatform.presentation.ui.SampleComposeMultiplatformScreen
import kmp.shared.samplesharedviewmodel.vm.SampleSharedEvent
import kmp.shared.samplesharedviewmodel.vm.SampleSharedIntent
import kmp.shared.samplesharedviewmodel.vm.SampleSharedViewModel
import kotlinx.coroutines.flow.collectLatest
import org.koin.androidx.compose.getViewModel

internal fun NavGraphBuilder.sampleComposeMultiplatformMainRoute() {
    composableDestination(
        destination = SampleComposeMultiplatformGraph.Main,
    ) {
        SampleComposeMultiplatformMainRoute()
    }
}

@Composable
internal fun SampleComposeMultiplatformMainRoute(
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

    SampleComposeMultiplatformScreen(
        state = state,
        onIntent = { viewModel.onIntent(it) },
    )
}
