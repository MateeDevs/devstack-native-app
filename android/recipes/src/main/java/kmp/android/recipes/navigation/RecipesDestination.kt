package kmp.android.recipes.navigation

import androidx.annotation.StringRes
import kmp.android.shared.Feature

sealed class RecipesDestination(
    val route: String,
    @StringRes val name: Int,
    @StringRes val description: Int,
) {
    companion object {
        val root: String = Feature.Recipes.route
    }

    object List : RecipesDestination("$root/list", 0, 0)

    object Rope : RecipesDestination(
        "$root/rope",
        kmp.android.shared.R.string.recipes_view_rope_name,
        kmp.android.shared.R.string.recipes_view_rope_description,
    )

    object CanvasClock : RecipesDestination(
        "$root/clock",
        kmp.android.shared.R.string.recipes_view_clock_name,
        kmp.android.shared.R.string.recipes_view_clock_description,
    )

    object ListTransition : RecipesDestination(
        "$root/transition-list",
        kmp.android.shared.R.string.recipes_view_list_name,
        kmp.android.shared.R.string.recipes_view_list_description,
    )
}
