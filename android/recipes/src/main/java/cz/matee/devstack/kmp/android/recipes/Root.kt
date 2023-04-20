package cz.matee.devstack.kmp.android.recipes

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.navigation
import cz.matee.devstack.kmp.android.recipes.navigation.RecipesDestination
import cz.matee.devstack.kmp.android.recipes.ui.CanvasRecipe
import cz.matee.devstack.kmp.android.recipes.ui.ListTransitionRecipe
import cz.matee.devstack.kmp.android.recipes.ui.RecipesScreen
import cz.matee.devstack.kmp.android.recipes.ui.RopeRecipe
import cz.matee.devstack.kmp.android.shared.navigation.Feature

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
