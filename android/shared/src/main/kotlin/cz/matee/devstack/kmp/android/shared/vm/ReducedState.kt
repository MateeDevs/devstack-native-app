package cz.matee.devstack.kmp.android.shared.vm

data class ReducedState<out State, out Event>(
    val reducedState: State,
    val event: Event?,
)
