package cz.matee.devstack.kmp.android.videos.vm

import cz.matee.devstack.kmp.android.shared.vm.BaseIntentViewModel
import cz.matee.devstack.kmp.android.shared.vm.VmIntent
import cz.matee.devstack.kmp.android.shared.vm.VmState
import cz.matee.devstack.kmp.shared.base.ErrorResult
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

data class VideosState(
    val loading: Boolean = false,
) : VmState

class VideosViewModel(
) : BaseIntentViewModel<VideosState, VideosIntent>(VideosState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>()
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    override suspend fun applyIntent(intent: VideosIntent) {
        TODO("Not yet implemented")
    }
}

sealed interface VideosIntent : VmIntent {
    object LoadData : VideosIntent
}
