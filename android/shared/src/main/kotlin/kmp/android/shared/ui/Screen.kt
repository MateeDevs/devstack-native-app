package kmp.android.shared.ui

import androidx.annotation.StringRes
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.offset
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.zIndex
import kmp.android.shared.style.Values

@Composable
fun ScreenTitle(
    @StringRes title: Int,
    modifier: Modifier = Modifier,
    background: Color = MaterialTheme.colors.background,
    showFade: Boolean = true,
    statusBarPadding: Boolean = true,
    content: @Composable RowScope.() -> Unit = {},
) {
    val density = LocalDensity.current.density
    val shadeHeight = remember(density) { Values.Space.mediumSmall }
    val shadeHeightPx = remember(shadeHeight) { shadeHeight.value * density }

    Box(modifier.zIndex(1f)) {
        if (showFade) {
            Box(
                Modifier
                    .fillMaxWidth()
                    .height(shadeHeight)
                    .align(Alignment.BottomCenter)
                    .offset { IntOffset(x = 0, y = shadeHeightPx.toInt()) }
                    .background(
                        Brush.verticalGradient(
                            listOf(background, Color.Transparent),
                            endY = shadeHeightPx,
                        ),
                    ),
            )
        }
        Row(
            Modifier
                .fillMaxWidth()
                .background(background)
                .let { if (statusBarPadding) it.statusBarsPadding() else it },
            verticalAlignment = Alignment.CenterVertically,
        ) {
            Text(
                stringResource(title),
                style = MaterialTheme.typography.h4,
                modifier = Modifier
                    .padding(start = Values.Space.medium)
                    .align(Alignment.Top),
            )

            content()
        }
    }
}
