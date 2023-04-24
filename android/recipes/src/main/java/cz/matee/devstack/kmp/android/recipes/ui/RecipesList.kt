package cz.matee.devstack.kmp.android.recipes.ui

import androidx.compose.animation.ExperimentalAnimationApi
import androidx.compose.animation.animateColor
import androidx.compose.animation.animateContentSize
import androidx.compose.animation.core.animateDp
import androidx.compose.animation.core.animateFloat
import androidx.compose.animation.core.updateTransition
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.itemsIndexed
import androidx.compose.material.*
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowForward
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.recipes.R
import cz.matee.devstack.kmp.android.recipes.navigation.RecipesDestination
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle

@Composable
fun RecipesScreen(navHostController: NavHostController) {
    Column {
        ScreenTitle(cz.matee.devstack.kmp.android.shared.R.string.recipes_view_toolbar_title)

        val items = remember {
            listOf(
                RecipesDestination.Rope,
                RecipesDestination.CanvasClock,
                RecipesDestination.ListTransition
            )
        }

        var expandedItem by remember { mutableStateOf<Int?>(null) }

        LazyColumn(
            Modifier.fillMaxSize(),
            verticalArrangement = Arrangement.spacedBy(Values.Space.medium)
        ) {

            item { Spacer(Modifier.height(Values.Space.small)) }

            itemsIndexed(items) { index, item ->
                RecipeItem(
                    item,
                    selected = expandedItem == index,
                    onNavigate = { navHostController.navigate(item.route) },
                    onSelect = { expandedItem = index },
                    onDeselect = { expandedItem = null }
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
    onDeselect: () -> Unit
) {
    val selectedTransition = updateTransition(selected)

    val cardElevation by selectedTransition.animateDp { isSelected ->
        if (isSelected) Values.Elevation.huge else Values.Elevation.small
    }
    val tintColor by selectedTransition.animateColor { isSelected ->
        if (isSelected)
            MaterialTheme.colors.primary
        else
            MaterialTheme.colors.onSurface
    }
    val descriptionAlpha by selectedTransition.animateFloat { isSelected ->
        if (isSelected) 1f else 0f
    }

    Card(
        Modifier
            .fillMaxWidth()
            .padding(horizontal = Values.Space.medium),
        elevation = cardElevation
    ) {
        Column(
            Modifier
                .clickable { if (selected) onDeselect() else onSelect() }
                .padding(Values.Space.medium)
        ) {

            Row(Modifier.fillMaxWidth(), Arrangement.SpaceBetween, Alignment.CenterVertically) {
                Text(
                    stringResource(destination.name),
                    Modifier.weight(0.1f),
                    style = MaterialTheme.typography.h6,
                    color = tintColor
                )
                IconButton(onClick = onNavigate) {
                    Icon(
                        Icons.Default.ArrowForward,
                        "Show detail",
                        tint = tintColor
                    )
                }
            }

            Text(
                stringResource(destination.description),
                Modifier
                    .fillMaxWidth()
                    .alpha(descriptionAlpha)
                    .animateContentSize()
                    .let { if (!selected) it.height(0.dp) else it }
            )
        }
    }
}