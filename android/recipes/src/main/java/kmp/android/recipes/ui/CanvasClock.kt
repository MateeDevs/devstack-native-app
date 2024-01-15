package kmp.android.recipes.ui

import androidx.compose.animation.Crossfade
import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.DraggableState
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.draggable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Pause
import androidx.compose.material.icons.filled.PlayArrow
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Rect
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.graphics.PathEffect
import androidx.compose.ui.graphics.StampedPathEffectStyle
import androidx.compose.ui.graphics.StrokeCap
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.navigation.NavController
import androidx.navigation.NavGraphBuilder
import kmp.android.recipes.navigation.RecipesGraph
import kmp.android.shared.R
import kmp.android.shared.navigation.dialogDestination
import kmp.android.shared.style.Values
import kotlinx.coroutines.delay
import kotlinx.coroutines.isActive

fun NavController.navigateToCanvasRecipe() {
    navigate(RecipesGraph.CanvasClock())
}

internal fun NavGraphBuilder.canvasRecipeRoute() {
    dialogDestination(
        destination = RecipesGraph.CanvasClock,
    ) {
        CanvasRecipesRoute()
    }
}

@Composable
internal fun CanvasRecipesRoute() {
    CanvasRecipe()
}

@Composable
private fun CanvasRecipe(modifier: Modifier = Modifier) {
    var usedTimer by remember { mutableStateOf(false) }
    var progress by remember { mutableStateOf(120f) }
    val helpAlpha by animateFloatAsState(if (usedTimer) 0f else 0.6f)

    var clockResumed by remember { mutableStateOf(false) }

    val dragState = remember {
        DraggableState { delta ->
            if (clockResumed) return@DraggableState
            if (!usedTimer) usedTimer = true
            val newProgress = progress + (delta / 4)
            progress = newProgress.coerceIn(12f..360f)
        }
    }

    LaunchedEffect(clockResumed) {
        while (isActive && clockResumed) {
            delay(1000L)
            val newProgress = progress - 6f
            progress = newProgress.coerceAtLeast(0f)
            if (progress == 0f) clockResumed = false
        }
    }

    Box(
        modifier
            .fillMaxSize()
            .draggable(dragState, Orientation.Vertical)
            .background(MaterialTheme.colors.background),
    ) {
        Text(
            stringResource(R.string.recipes_clock_view_tutorial),
            Modifier
                .align(Alignment.TopCenter)
                .statusBarsPadding()
                .padding(Values.Space.medium)
                .alpha(helpAlpha),
            style = MaterialTheme.typography.h4,
            textAlign = TextAlign.Center,
        )

        val animatedProgress by animateFloatAsState(progress)
        Clock(progress = if (clockResumed) animatedProgress else progress)

        ClockCenter(
            seconds = (progress / 6).toInt(),
            clockResumed = clockResumed,
            changeClockResumed = { clockResumed = it },
            Modifier.align(Alignment.Center),
        )
    }
}

@Composable
private fun ClockCenter(
    seconds: Int,
    clockResumed: Boolean,
    changeClockResumed: (Boolean) -> Unit,
    modifier: Modifier = Modifier,
) {
    Column(modifier, horizontalAlignment = Alignment.CenterHorizontally) {
        Text(
            stringResource(R.string.many_seconds, seconds),
            style = MaterialTheme.typography.h6,
        )

        Spacer(Modifier.height(Values.Space.mediumSmall))

        Crossfade(clockResumed) {
            IconButton(onClick = { changeClockResumed(!clockResumed) }) {
                if (it) {
                    Icon(Icons.Default.Pause, "Pause")
                } else {
                    Icon(Icons.Default.PlayArrow, "Play")
                }
            }
        }
    }
}

@Composable
private fun Clock(progress: Float) {
    val density = LocalDensity.current.density

    val clockMainColor = MaterialTheme.colors.primary
    val clockBackgroundColor = MaterialTheme.colors.surface
    val clockSecondMarkColor = MaterialTheme.colors.onBackground.copy(alpha = 0.5f)

    val clockStyle = remember {
        Stroke(
            12f * density,
            cap = StrokeCap.Round,
        )
    }
    val clockBackgroundStyle = remember { Stroke(14f * density) }

    val line = Path().apply {
        addRect(
            Rect(
                Offset(-1f * density, -8f * density),
                Offset(1f * density, 8f * density),
            ),
        )
        close()
    }
    var clockCircumference by remember { mutableStateOf(0f) }
    val linesStyle = remember(clockCircumference) {
        Stroke(
            16f * density,
            pathEffect = PathEffect.stampedPathEffect(
                line,
                clockCircumference / 60f,
                0f,
                StampedPathEffectStyle.Rotate,
            ),
        )
    }

    Canvas(
        Modifier
            .fillMaxSize()
            .padding(Values.Space.large)
            .aspectRatio(1f),
    ) {
        clockCircumference = (Math.PI * size.width).toFloat()
        drawCircle(clockBackgroundColor, style = clockBackgroundStyle)
        drawCircle(clockSecondMarkColor, style = linesStyle)
        drawArc(
            clockMainColor,
            -90f,
            progress,
            false,
            style = clockStyle,
        )
    }
}
