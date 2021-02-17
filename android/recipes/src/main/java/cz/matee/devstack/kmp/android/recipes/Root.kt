package cz.matee.devstack.kmp.android.recipes

import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import dev.chrisbanes.accompanist.insets.statusBarsPadding

@Suppress("FunctionName")
fun NavGraphBuilder.RecipesRoot(navHostController: NavHostController) {
    composable(Feature.Recipes.route) {
        Text(
            stringResource(Feature.Recipes.titleRes),
            style = MaterialTheme.typography.h3,
            modifier = Modifier.statusBarsPadding()
        )
    }
}