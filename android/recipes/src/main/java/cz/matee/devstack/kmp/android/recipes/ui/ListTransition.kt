package cz.matee.devstack.kmp.android.recipes.ui

import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.animateIntOffset
import androidx.compose.animation.core.spring
import androidx.compose.animation.core.updateTransition
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.LazyListScope
import androidx.compose.foundation.lazy.LazyListState
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material.Divider
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.input.nestedscroll.NestedScrollConnection
import androidx.compose.ui.input.nestedscroll.NestedScrollSource
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.layout.onSizeChanged
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.*
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.util.composition.LocalScaffoldPadding
import dev.chrisbanes.accompanist.insets.statusBarsPadding

private val headerMaxHeight by lazy { 128.dp }
private val headerMinHeight by lazy { 64.dp }

@Composable
fun ListTransitionRecipe() {
    LazyColumnWithCollapsingToolbar("Title") {
        repeat(51) {
            item {
                Text(
                    "Item $it",
                    Modifier.fillMaxWidth(),
                    style = MaterialTheme.typography.h5
                )
                Divider()
            }
        }
    }
}


@Composable
private fun LazyColumnWithCollapsingToolbar(
    title: String,
    content: LazyListScope.() -> Unit
) {
    val density = LocalDensity.current.density
    val rootPadding = LocalScaffoldPadding.current
    val listState = rememberLazyListState()

    var headerHeight by remember { mutableStateOf(128.dp) }

    val headerTransitionProgress =
        (headerHeight - headerMinHeight) / (headerMaxHeight - headerMinHeight)
    val scrollTransition = updateTransition(headerTransitionProgress)

    var titleParentSize by remember { mutableStateOf(IntSize.Zero) }
    var titleSize by remember { mutableStateOf(IntSize.Zero) }
    val titleBaseSize = MaterialTheme.typography.h5.fontSize.value

    val titleFontSize by scrollTransition.animateFloat { progress ->
        titleBaseSize + (progress * 24f)
    }

    val titleOffset by scrollTransition.animateIntOffset(
        transitionSpec = { spring() }
    ) {
        if (it > 0f) Offset.Zero.round()
        else IntOffset(-(titleParentSize.width / 2) + titleSize.width / 2, 0)
    }

    val nestedScrollConnection = remember {
        object : NestedScrollConnection {
            override fun onPreScroll(available: Offset, source: NestedScrollSource): Offset {
                val scrollInDp = available.y / density

                if (scrollInDp > 0 && !listState.isAtTop)
                    return Offset.Zero

                val newHeightDp = (headerHeight.value + scrollInDp)
                    .coerceIn(headerMinHeight.value..headerMaxHeight.value)

                val consumedDp = newHeightDp - headerHeight.value
                headerHeight = Dp(newHeightDp)
                return Offset(0f, consumedDp * density)
            }
        }
    }

    Column(
        Modifier
            .fillMaxSize()
            .statusBarsPadding()
            .padding(bottom = rootPadding.calculateBottomPadding())
            .nestedScroll(nestedScrollConnection)
    ) {
        Box(
            Modifier
                .fillMaxWidth()
                .requiredHeight(headerHeight)
                .background(MaterialTheme.colors.surface)
                .onSizeChanged { titleParentSize = it }
        ) {
            Text(
                title,
                fontSize = titleFontSize.sp,
                textAlign = TextAlign.Center,
                modifier = Modifier
                    .align(Alignment.Center)
                    .padding(start = Values.Space.medium * (1 - headerTransitionProgress))
                    .offset { titleOffset }
                    .onSizeChanged { titleSize = it }
            )
        }

        LazyColumn(Modifier.fillMaxSize(), listState) {
            content()
        }
    }
}

private val LazyListState.isAtTop get() = firstVisibleItemIndex == 0 && firstVisibleItemScrollOffset == 0