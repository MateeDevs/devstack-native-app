package kmp.android.recipes.domain.model

import androidx.annotation.StringRes
import kmp.android.shared.R

enum class RecipesTarget(@StringRes val titleRes: Int, @StringRes val descriptionRes: Int) {
    Rope(
        titleRes = R.string.recipes_view_rope_name,
        descriptionRes = R.string.recipes_view_rope_description,
    ),

    CanvasClock(
        titleRes = R.string.recipes_view_clock_name,
        descriptionRes = R.string.recipes_view_clock_description,
    ),

    ListTransition(
        titleRes = R.string.recipes_view_list_name,
        descriptionRes = R.string.recipes_view_list_description,
    ),
}
