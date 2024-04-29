package kmp.android.recipes.ui

import androidx.compose.animation.core.animateOffsetAsState
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.requiredSize
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.round
import androidx.navigation.NavController
import androidx.navigation.NavGraphBuilder
import kmp.android.recipes.navigation.RecipesGraph
import kmp.android.shared.navigation.dialogDestination
import kmp.android.shared.style.Values
import kotlin.math.roundToInt

fun NavController.navigateToRopeRecipe() {
    navigate(RecipesGraph.Rope())
}

internal fun NavGraphBuilder.ropeRecipeRoute() {
    dialogDestination(
        destination = RecipesGraph.Rope,
    ) {
        RopeRecipeRoute()
    }
}

@Composable
internal fun RopeRecipeRoute() {
    RopeRecipe()
}

private val ballSizeDp = 96.dp

@Composable
private fun RopeRecipe(modifier: Modifier = Modifier) {
    val density = LocalDensity.current.density
    val ballSizePx = remember(density) { ballSizeDp.value * density }

    val ballSpacingPx = remember { Offset(0f, (48.dp + ballSizeDp).value * density) }
    var ball1 by remember { mutableStateOf(Offset.Zero) }
    val ball2 by animateOffsetAsState(ball1 + ballSpacingPx)
    val ball3 by animateOffsetAsState(ball2 + ballSpacingPx)

    val lineColor = MaterialTheme.colors.onBackground
    val ballCenterOffset = remember { Offset(ballSizePx / 2, ballSizePx) }
    Box(modifier.fillMaxSize().background(MaterialTheme.colors.background)) {
        Canvas(Modifier.fillMaxSize()) {
            drawLine(
                lineColor,
                ball1 + ballCenterOffset,
                ball2 + ballCenterOffset,
                Values.Border.thick.value * density,
            )
            drawLine(
                lineColor,
                ball2 + ballCenterOffset,
                ball3 + ballCenterOffset,
                Values.Border.thick.value * density,
            )
        }

        Box(
            Modifier
                .fillMaxSize()
                .pointerInput(Unit) {
                    detectDragGestures { change, dragAmount ->
                        change.consume()
                        ball1 += dragAmount
                    }
                }
                .statusBarsPadding()
                .navigationBarsPadding(),
        ) {
            Spacer(Modifier.height(Values.Space.medium))
            Ball(offset = ball1)
            Ball(offset = ball2)
            Ball(offset = ball3)
        }
    }
}

@Composable
private fun Ball(offset: Offset) {
    Box(
        Modifier
            .offset { offset.round() }
            .requiredSize(ballSizeDp)
            .background(MaterialTheme.colors.primary, CircleShape),
    ) {
        Column(Modifier.align(Alignment.Center)) {
            Text(text = "X: ${offset.x.roundToInt()}")
            Text(text = "Y: ${offset.y.roundToInt()}")
        }
    }
}
