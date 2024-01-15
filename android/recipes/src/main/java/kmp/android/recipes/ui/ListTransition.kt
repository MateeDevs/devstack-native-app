package kmp.android.recipes.ui

import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.animateIntOffset
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.updateTransition
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.requiredHeight
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.Divider
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
import androidx.compose.ui.input.nestedscroll.NestedScrollConnection
import androidx.compose.ui.input.nestedscroll.NestedScrollSource
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.IntSize
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.round
import androidx.compose.ui.unit.sp
import androidx.navigation.NavController
import androidx.navigation.NavGraphBuilder
import kmp.android.recipes.navigation.RecipesGraph
import kmp.android.shared.navigation.dialogDestination
import kmp.android.shared.style.Values

fun NavController.navigateToListTransitionRecipe() {
    navigate(RecipesGraph.ListTransition())
}

internal fun NavGraphBuilder.listTransitionRecipeRoute() {
    dialogDestination(
        destination = RecipesGraph.ListTransition,
    ) {
        ListTransitionRecipeRoute()
    }
}

@Composable
internal fun ListTransitionRecipeRoute() {
    ListTransitionRecipe()
}

private val headerMaxHeight by lazy { 128.dp }
private val headerMinHeight by lazy { 64.dp }

@Composable
private fun ListTransitionRecipe(modifier: Modifier = Modifier) {
    LazyColumnWithCollapsingToolbar(
        title = "Title",
        modifier = modifier.background(MaterialTheme.colors.background),
    ) {
        repeat(51) {
            item {
                Text(
                    "Item $it",
                    Modifier.fillMaxWidth(),
                    style = MaterialTheme.typography.h5,
                )
                Divider()
            }
        }
    }
}

@Composable
private fun LazyColumnWithCollapsingToolbar(
    title: String,
    modifier: Modifier = Modifier,
    content: LazyListScope.() -> Unit,
) {
    val density = LocalDensity.current.density
    val listState = rememberLazyListState()

    var headerHeight by remember { mutableStateOf(128.dp) }

    val headerTransitionProgress =
        (headerHeight - headerMinHeight) / (headerMaxHeight - headerMinHeight)
    val scrollTransition = updateTransition(headerTransitionProgress, label = "scrollTransition")

    var titleParentSize by remember { mutableStateOf(IntSize.Zero) }
    var titleSize by remember { mutableStateOf(IntSize.Zero) }
    val titleBaseSize = MaterialTheme.typography.h5.fontSize.value

    val titleFontSize by scrollTransition.animateFloat(label = "titleFontSize") { progress ->
        titleBaseSize + (progress * 24f)
    }

    val titleOffset by scrollTransition.animateIntOffset(
        transitionSpec = { spring() },
        label = "titleOffset",
    ) {
        if (it > 0f) {
            Offset.Zero.round()
        } else {
            IntOffset(-(titleParentSize.width / 2) + titleSize.width / 2, 0)
        }
    }

    val nestedScrollConnection = remember {
        object : NestedScrollConnection {
            override fun onPreScroll(available: Offset, source: NestedScrollSource): Offset {
                val scrollInDp = available.y / density

                if (scrollInDp > 0 && !listState.isAtTop) {
                    return Offset.Zero
                }

                val newHeightDp = (headerHeight.value + scrollInDp)
                    .coerceIn(headerMinHeight.value..headerMaxHeight.value)

                val consumedDp = newHeightDp - headerHeight.value
                headerHeight = Dp(newHeightDp)
                return Offset(0f, consumedDp * density)
            }
        }
    }

    Column(
        modifier
            .fillMaxSize()
            .statusBarsPadding()
            .nestedScroll(nestedScrollConnection),
    ) {
        Box(
            Modifier
                .fillMaxWidth()
                .requiredHeight(headerHeight)
                .background(MaterialTheme.colors.surface)
                .onSizeChanged { titleParentSize = it },
        ) {
            Text(
                title,
                fontSize = titleFontSize.sp,
                textAlign = TextAlign.Center,
                modifier = Modifier
                    .align(Alignment.Center)
                    .padding(start = Values.Space.medium * (1 - headerTransitionProgress))
                    .offset { titleOffset }
                    .onSizeChanged { titleSize = it },
            )
        }

        LazyColumn(Modifier.fillMaxSize(), listState) {
            content()
        }
    }
}

private val LazyListState.isAtTop get() = firstVisibleItemIndex == 0 && firstVisibleItemScrollOffset == 0
