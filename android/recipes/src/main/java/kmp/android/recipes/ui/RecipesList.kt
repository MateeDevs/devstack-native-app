package kmp.android.recipes.ui

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.animation.animateColor
import androidx.compose.animation.animateContentSize
import androidx.compose.animation.core.animateDp
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.updateTransition
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material.Card
import androidx.compose.material.Icon
import androidx.compose.material.IconButton
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowForward
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import kmp.android.recipes.navigation.RecipesDestination
import kmp.android.shared.style.Values
import kmp.android.shared.R
import kmp.android.shared.ui.ScreenTitle

@Composable
fun RecipesScreen(navHostController: NavHostController, modifier: Modifier = Modifier) {
    Column(modifier = modifier) {
        ScreenTitle(R.string.recipes_view_toolbar_title)

        val items = remember {
            listOf(
                RecipesDestination.Rope,
                RecipesDestination.CanvasClock,
                RecipesDestination.ListTransition,
            )
        }

        var expandedItem by remember { mutableStateOf<Int?>(null) }

        LazyColumn(
            Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.spacedBy(Values.Space.medium),
        ) {
            item { Spacer(Modifier.height(Values.Space.small)) }

            itemsIndexed(items) { index, item ->
                RecipeItem(
                    item,
                    selected = expandedItem == index,
                    onNavigate = { navHostController.navigate(item.route) },
                    onSelect = { expandedItem = index },
                    onDeselect = { expandedItem = null },
                )
            }
        }
    }
}

@OptIn(ExperimentalAnimationApi::class)
@Composable
private fun RecipeItem(
    destination: RecipesDestination,
    selected: Boolean,
    onNavigate: () -> Unit,
    onSelect: () -> Unit,
    onDeselect: () -> Unit,
) {
    val selectedTransition = updateTransition(selected, label = "selected item")

    val cardElevation by selectedTransition.animateDp(label = "selected elevation") { isSelected ->
        if (isSelected) Values.Elevation.huge else Values.Elevation.small
    }
    val tintColor by selectedTransition.animateColor(label = "selected color") { isSelected ->
        if (isSelected) {
            MaterialTheme.colors.primary
        } else {
            MaterialTheme.colors.onSurface
        }
    }
    val descriptionAlpha by selectedTransition.animateFloat(label = "selected alpha") { isSelected ->
        if (isSelected) 1f else 0f
    }

    Card(
        Modifier
            .fillMaxWidth()
            .padding(horizontal = Values.Space.medium),
        elevation = cardElevation,
    ) {
        Column(
            Modifier
                .clickable { if (selected) onDeselect() else onSelect() }
                .padding(Values.Space.medium),
        ) {
            Row(Modifier.fillMaxWidth(), Arrangement.SpaceBetween, Alignment.CenterVertically) {
                Text(
                    stringResource(destination.name),
                    Modifier.weight(0.1f),
                    style = MaterialTheme.typography.h6,
                    color = tintColor,
                )
                IconButton(onClick = onNavigate) {
                    Icon(
                        Icons.Default.ArrowForward,
                        "Show detail",
                        tint = tintColor,
                    )
                }
            }

            Text(
                stringResource(destination.description),
                Modifier
                    .fillMaxWidth()
                    .alpha(descriptionAlpha)
                    .animateContentSize()
                    .let { if (!selected) it.height(0.dp) else it },
            )
        }
    }
}
