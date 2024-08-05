package kmp.shared.samplecomposemultiplatform.presentation

import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.ui.uikit.ComposeUIViewControllerDelegate
import androidx.compose.ui.window.ComposeUIViewController
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import kmp.shared.samplecomposemultiplatform.presentation.common.AppTheme
import kmp.shared.samplecomposemultiplatform.presentation.ui.SampleComposeMultiplatformScreen
import kmp.shared.samplesharedviewmodel.base.vm.BaseScopedViewModel
import kmp.shared.samplesharedviewmodel.vm.SampleSharedEvent
import kmp.shared.samplesharedviewmodel.vm.SampleSharedIntent
import kmp.shared.samplesharedviewmodel.vm.SampleSharedViewModel
import kotlinx.coroutines.flow.collectLatest
import platform.UIKit.UIViewController

@Suppress("Unused", "FunctionName")
fun SampleComposeMultiplatformScreenViewController(
    viewModel: SampleSharedViewModel,
    onEvent: (SampleSharedEvent) -> Unit,
): UIViewController {
    return ComposeUIViewController(
        configure = {
            delegate = object : ComposeUIViewControllerDelegate {
                override fun viewDidLoad() {
                    super.viewDidLoad()
                    viewModel.onIntent(SampleSharedIntent.OnAppeared)
                }

                override fun viewDidDisappear(animated: Boolean) {
                    super.viewDidDisappear(animated)
                    (viewModel as BaseScopedViewModel<*, *, *>).clear()
                }
            }
        },
    ) {
        val state by viewModel.state.collectAsStateWithLifecycle()
        LaunchedEffect(viewModel) {
            viewModel.events.collectLatest { event ->
                onEvent(event)
            }
        }
        AppTheme {
            SampleComposeMultiplatformScreen(state = state, onIntent = viewModel::onIntent)
        }
    }
}
