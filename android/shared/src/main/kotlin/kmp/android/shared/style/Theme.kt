package kmp.android.shared.style

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Colors
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Shapes
import androidx.compose.material.Typography
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

// https://coolors.co/f5ab00-b8a422-9aa133-7b9d44-d95700-e0e0e0-f0f0f0
val lightColors = Colors(
    primary = Color(0xFFF5AB00),
    primaryVariant = Color(0xFFB8A422),

    secondary = Color(0xFF7B9D44),
    secondaryVariant = Color(0xFF9AA133),

    background = Color(0xFFF0F0F0),
    surface = Color(0xFFE0E0E0),

    error = Color(0xFFD95700),

    onPrimary = Color(0xFFFFFFFF),
    onSecondary = Color(0xFF000000),
    onBackground = Color(0xFF000000),
    onSurface = Color(0xFF000000),
    onError = Color(0xFF000000),

    isLight = true,
)

// https://coolors.co/f5ab00-b8a422-9aa133-7b9d44-d95700-1f1f1f-141414
val darkColors = Colors(
    primary = Color(0xFFF5AB00),
    primaryVariant = Color(0xFFB8A422),

    secondary = Color(0xFF7B9D44),
    secondaryVariant = Color(0xFF9AA133),

    background = Color(0xFF141414),
    surface = Color(0xFF1F1F1F),

    error = Color(0xFFD95700),

    onPrimary = Color(0xFFFFFFFF),
    onSecondary = Color(0xFF000000),
    onBackground = Color(0xFFFFFFFF),
    onSurface = Color(0xFFFFFFFF),
    onError = Color(0xFFFFFFFF),

    isLight = false,
)

val typography = Typography(
    // Define typohraphy
)

val shapes = Shapes(
    small = RoundedCornerShape(Values.Radius.large),
    medium = RoundedCornerShape(Values.Radius.medium),
    large = RoundedCornerShape(Values.Radius.small),
)

@Composable
fun AppTheme(darkTheme: Boolean = isSystemInDarkTheme(), content: @Composable () -> Unit) {
    val colors = if (darkTheme) darkColors else lightColors
    MaterialTheme(
        colors = colors,
        typography = typography,
        shapes = shapes,
        content = content,
    )
}
