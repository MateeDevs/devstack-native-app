package cz.matee.devstack.kmp.shared.utils

import kotlinx.coroutines.flow.flow

/**
 * This object is needed because of Tests on iOS platform.
 */
object FlowTestHelper {
    fun <T> arrayToFlow(array: List<T>) = flow<T> {
        array.forEach {
            emit(it)
        }
    }
}
