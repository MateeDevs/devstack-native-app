package kmp.android.shared.core.util

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kmp.android.shared.core.system.BaseStateViewModel
import kmp.android.shared.core.system.State
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.launch
import kotlin.reflect.KProperty1

/**
 * Launch coroutine on Main thread
 * @param block The body of the coroutine
 * @return reference to the coroutine as a [Job]
 */
public fun ViewModel.launchOnMain(
    block: suspend CoroutineScope.() -> Unit,
): Job = viewModelScope.launch(Dispatchers.Main, block = block)

/**
 * Retrieve flow of one property of ViewModels state.
 * @param prop property of State from which Flow should be created
 * @return [Flow] of changes to given property
 */
public operator fun <S : State, R> BaseStateViewModel<S>.get(
    prop: KProperty1<S, R>,
): Flow<R> = state
    .map { prop.get(it) }
    .distinctUntilChanged()

/**
 * Retrieve flow of two properties of ViewModels state.
 * @param prop1, prop2 properties of State from which Flow should be created
 * @return [Flow] of changes to given properties
 */
public fun <S : State, R1, R2> BaseStateViewModel<S>.getStateProperties(
    prop1: KProperty1<S, R1>,
    prop2: KProperty1<S, R2>,
): Flow<Pair<R1, R2>> = state
    .map { prop1.get(it) to prop2.get(it) }
    .distinctUntilChanged()
