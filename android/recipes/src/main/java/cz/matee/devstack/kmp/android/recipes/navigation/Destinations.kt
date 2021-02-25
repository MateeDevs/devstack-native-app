package cz.matee.devstack.kmp.android.recipes.navigation

import androidx.annotation.StringRes

sealed class RecipesDestination(val route: String, @StringRes val titleRes: Int) {
//    object Recipes : RecipesDestination("recipes", R.string.recipes_view_toolbar_title)
}