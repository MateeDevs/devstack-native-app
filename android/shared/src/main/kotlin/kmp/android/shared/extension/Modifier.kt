package kmp.android.shared.extension

import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.ime
import androidx.compose.foundation.layout.offset
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.layout.positionInWindow
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import kotlin.math.roundToInt

fun Modifier.pushedByIme(additionalSpace: Int = 0) = composed {
    var bottomPosition by remember { mutableStateOf(0) }
    val spaceFromBottom = LocalView.current.height - bottomPosition
    val insets = WindowInsets.ime

    val bottomOffset = (insets.getBottom(LocalDensity.current) - spaceFromBottom + additionalSpace)
        .coerceAtLeast(0)

    onGloballyPositioned {
        if (bottomPosition == 0) {
            // Get only first position
            bottomPosition = (it.positionInWindow().y + it.size.height).roundToInt()
        }
    }.offset { IntOffset(0, -bottomOffset) }
}

fun Modifier.pushedByIme(additionalSpace: Dp = 0.dp) = composed {
    val density = LocalDensity.current.density
    pushedByIme((additionalSpace.value * density).toInt())
}
