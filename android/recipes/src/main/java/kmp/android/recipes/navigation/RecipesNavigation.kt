package kmp.android.recipes.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.recipes.domain.model.RecipesTarget
import kmp.android.recipes.ui.canvasRecipeRoute
import kmp.android.recipes.ui.listTransitionRecipeRoute
import kmp.android.recipes.ui.navigateToCanvasRecipe
import kmp.android.recipes.ui.navigateToListTransitionRecipe
import kmp.android.recipes.ui.navigateToRopeRecipe
import kmp.android.recipes.ui.recipesRoute
import kmp.android.recipes.ui.ropeRecipeRoute

fun NavGraphBuilder.recipesNavGraph(navHostController: NavHostController) {
    navigation(
        startDestination = RecipesGraph.List.route,
        route = RecipesGraph.rootPath,
    ) {
        recipesRoute(
            navigateToTarget = { target ->
                when (target) {
                    RecipesTarget.Rope -> navHostController.navigateToRopeRecipe()
                    RecipesTarget.CanvasClock -> navHostController.navigateToCanvasRecipe()
                    RecipesTarget.ListTransition -> navHostController.navigateToListTransitionRecipe()
                }
            },
        )

        canvasRecipeRoute()
        ropeRecipeRoute()
        listTransitionRecipeRoute()
    }
}
