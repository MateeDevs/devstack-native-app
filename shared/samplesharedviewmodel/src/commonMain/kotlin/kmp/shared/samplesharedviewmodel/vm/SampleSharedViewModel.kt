package kmp.shared.samplesharedviewmodel.vm

import kmp.shared.base.ErrorResult
import kmp.shared.base.Result
import kmp.shared.sample.domain.model.SampleText
import kmp.shared.sample.domain.usecase.GetSampleTextUseCase
import org.skyseat.shared.base.viewmodel.BaseViewModel
import org.skyseat.shared.base.viewmodel.VmEvent
import org.skyseat.shared.base.viewmodel.VmIntent
import org.skyseat.shared.base.viewmodel.VmState

class SampleSharedViewModel(
    private val getSampleText: GetSampleTextUseCase,
) : BaseViewModel<SampleSharedState, SampleSharedIntent, SampleSharedEvent>(SampleSharedState()) {

    override suspend fun applyIntent(intent: SampleSharedIntent) {
        when (intent) {
            SampleSharedIntent.OnAppeared -> loadSampleText()
            SampleSharedIntent.OnButtonTapped -> _events.emit(SampleSharedEvent.ShowMessage("Button was tapped"))
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

data class SampleSharedState(
    val loading: Boolean = false,
    val sampleText: SampleText? = null,
    val error: ErrorResult? = null,
) : VmState

sealed interface SampleSharedIntent : VmIntent {
    data object OnAppeared : SampleSharedIntent
    data object OnButtonTapped : SampleSharedIntent
}

sealed interface SampleSharedEvent : VmEvent {
    data class ShowMessage(val message: String) : SampleSharedEvent
}
