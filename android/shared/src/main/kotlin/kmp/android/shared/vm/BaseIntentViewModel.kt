package kmp.android.shared.vm

import androidx.compose.runtime.Immutable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.setValue
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.launch

abstract class BaseIntentViewModel<S : VmState, I : VmIntent>(initialState: S) : ViewModel() {

    var state: S by mutableStateOf(initialState)
        protected set

    fun onIntent(intent: I) {
        viewModelScope.launch {
            applyIntent(intent)
        }
    }

    protected abstract suspend fun applyIntent(intent: I)
}

/**
 * Base state of every view that is held in view model.
 */
@Immutable
interface VmState

/**
 * Base intent interface
 */
interface VmIntent
