package cz.matee.devstack.kmp.android.recipes.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.recipes.R
import cz.matee.devstack.kmp.android.shared.ui.ScreenTitle

@Composable
fun RecipesScreen(navHostController: NavHostController) {
    Column {
        ScreenTitle(R.string.recipes_view_toolbar_title)


    }
}