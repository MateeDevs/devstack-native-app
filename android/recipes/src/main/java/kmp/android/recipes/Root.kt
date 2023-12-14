package kmp.android.recipes

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.navigation
import kmp.android.recipes.navigation.RecipesDestination
import kmp.android.recipes.ui.CanvasRecipe
import kmp.android.recipes.ui.ListTransitionRecipe
import kmp.android.recipes.ui.RecipesScreen
import kmp.android.recipes.ui.RopeRecipe
import kmp.android.shared.Feature

@Suppress("FunctionName")
fun NavGraphBuilder.RecipesRoot(navHostController: NavHostController) {
    navigation(RecipesDestination.List.route, Feature.Recipes.route) {
        composable(RecipesDestination.List.route) {
            RecipesScreen(navHostController = navHostController)
        }

        composable(RecipesDestination.CanvasClock.route) { CanvasRecipe() }
        composable(RecipesDestination.Rope.route) { RopeRecipe() }
        composable(RecipesDestination.ListTransition.route) { ListTransitionRecipe() }
    }
}
