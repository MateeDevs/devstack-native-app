package cz.matee.devstack.kmp.android.recipes.ui

import androidx.compose.animation.core.animateOffsetAsState
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.input.pointer.consumeAllChanges
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.round
import cz.matee.devstack.kmp.android.shared.style.Values
import dev.chrisbanes.accompanist.insets.navigationBarsPadding
import dev.chrisbanes.accompanist.insets.statusBarsPadding
import kotlin.math.roundToInt

private const val ballSize = 96f

@Composable
fun RopeRecipe() {
    val density = LocalDensity.current.density
    val ballSizeScaled = remember(density) { ballSize * density }

    val ballSpacing = remember { Offset(0f, (48f + ballSize) * density) }
    var ball1 by remember { mutableStateOf(Offset.Zero) }
    val ball2 by animateOffsetAsState(ball1 + ballSpacing)
    val ball3 by animateOffsetAsState(ball2 + ballSpacing)


    val lineColor = MaterialTheme.colors.onBackground
    val ballCenterOffset = remember { Offset(ballSizeScaled / 2, ballSizeScaled) }
    Canvas(Modifier.fillMaxSize()) {
        drawLine(
            lineColor,
            ball1 + ballCenterOffset,
            ball2 + ballCenterOffset,
            Values.Border.thick.value * density
        )
        drawLine(
            lineColor,
            ball2 + ballCenterOffset,
            ball3 + ballCenterOffset,
            Values.Border.thick.value * density
        )
    }

    Box(
        Modifier
            .fillMaxSize()
            .pointerInput(Unit) {

                detectDragGestures { change, dragAmount ->
                    change.consumeAllChanges()
                    ball1 += dragAmount
                }
            }
            .statusBarsPadding()
            .navigationBarsPadding()
    ) {
        Spacer(Modifier.height(Values.Space.medium))
        Ball(offset = ball1)
        Ball(offset = ball2)
        Ball(offset = ball3)
    }
}

@Composable
private fun Ball(offset: Offset) {
    Box(
        Modifier
            .offset { offset.round() }
            .requiredSize(ballSize.dp)
            .background(MaterialTheme.colors.primary, CircleShape)
    ) {
        Column(Modifier.align(Alignment.Center)) {
            Text(text = "X: ${offset.x.roundToInt()}")
            Text(text = "Y: ${offset.y.roundToInt()}")
        }
    }
}