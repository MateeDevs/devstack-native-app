package kmp.android.recipes.navigation

import androidx.annotation.StringRes
import kmp.android.shared.Feature
import kmp.android.shared.R

sealed class RecipesDestination(
    val route: String,
    @StringRes val name: Int?,
    @StringRes val description: Int?,
) {
    companion object {
        val root: String = Feature.Recipes.route
    }

    object List : RecipesDestination("$root/list", null, null)

    object Rope : RecipesDestination(
        route = "$root/rope",
        name = R.string.recipes_view_rope_name,
        description = R.string.recipes_view_rope_description,
    )

    object CanvasClock : RecipesDestination(
        route = "$root/clock",
        name = R.string.recipes_view_clock_name,
        description = R.string.recipes_view_clock_description,
    )

    object ListTransition : RecipesDestination(
        route = "$root/transition-list",
        name = R.string.recipes_view_list_name,
        description = R.string.recipes_view_list_description,
    )
}
