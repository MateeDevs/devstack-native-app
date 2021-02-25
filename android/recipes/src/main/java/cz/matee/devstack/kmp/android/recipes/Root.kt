package cz.matee.devstack.kmp.android.recipes

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import cz.matee.devstack.kmp.android.recipes.ui.RecipesScreen
import cz.matee.devstack.kmp.android.shared.navigation.Feature

@Suppress("FunctionName")
fun NavGraphBuilder.RecipesRoot(navHostController: NavHostController) {
    composable(Feature.Recipes.route) {
        RecipesScreen(navHostController = navHostController)
    }
}