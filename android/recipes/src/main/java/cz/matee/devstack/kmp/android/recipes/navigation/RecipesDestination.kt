package cz.matee.devstack.kmp.android.recipes.navigation

import androidx.annotation.StringRes
import cz.matee.devstack.kmp.android.shared.navigation.Feature

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
        cz.matee.devstack.kmp.android.shared.R.string.recipes_view_rope_name,
        cz.matee.devstack.kmp.android.shared.R.string.recipes_view_rope_description,
    )

    object CanvasClock : RecipesDestination(
        "$root/clock",
        cz.matee.devstack.kmp.android.shared.R.string.recipes_view_clock_name,
        cz.matee.devstack.kmp.android.shared.R.string.recipes_view_clock_description,
    )

    object ListTransition : RecipesDestination(
        "$root/transition-list",
        cz.matee.devstack.kmp.android.shared.R.string.recipes_view_list_name,
        cz.matee.devstack.kmp.android.shared.R.string.recipes_view_list_description,
    )
}
