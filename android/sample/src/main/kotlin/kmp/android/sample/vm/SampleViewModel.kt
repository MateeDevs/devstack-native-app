package kmp.android.sample.vm

import kmp.android.shared.vm.BaseIntentViewModel
import kmp.android.shared.vm.VmEvent
import kmp.android.shared.vm.VmIntent
import kmp.android.shared.vm.VmState
import kmp.shared.base.ErrorResult
import kmp.shared.base.Result
import kmp.shared.sample.domain.model.SampleText
import kmp.shared.sample.domain.usecase.GetSampleTextUseCase

class SampleViewModel(
    private val getSampleText: GetSampleTextUseCase,
) : BaseIntentViewModel<SampleState, SampleIntent, SampleEvent>(SampleState()) {

    override suspend fun applyIntent(intent: SampleIntent) {
        when (intent) {
            SampleIntent.OnAppeared -> loadSampleText()
            SampleIntent.OnButtonTapped -> _events.emit(SampleEvent.ShowMessage("Button was tapped"))
        }
    }

    private suspend fun loadSampleText() {
        update { copy(loading = true) }
        when (val result = getSampleText()) {
            is Result.Success -> update { copy(sampleText = result.data, loading = false) }
            is Result.Error -> update { copy(error = result.error, loading = false) }
        }
    }
}

data class SampleState(
    val loading: Boolean = false,
    val sampleText: SampleText? = null,
    val error: ErrorResult? = null,
) : VmState

sealed interface SampleIntent : VmIntent {
    data object OnAppeared : SampleIntent
    data object OnButtonTapped : SampleIntent
}

sealed interface SampleEvent : VmEvent {
    data class ShowMessage(val message: String) : SampleEvent
}
