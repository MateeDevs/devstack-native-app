package cz.matee.devstack.kmp.android.shared.vm

data class ReducedState<out State, out Message>(
    val reducedState: State,
    val message: Message?,
)
