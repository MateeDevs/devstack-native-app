package cz.matee.devstack.kmp.android.shared.navigation

import androidx.annotation.StringRes
import cz.matee.devstack.kmp.android.shared.R

sealed class Feature(val route: String, @StringRes val titleRes: Int) {
    object Login : Feature("login", R.string.login_view_headline_title)

    object Profile : Feature("profile", R.string.bottom_bar_item_1)
    object Users : Feature("users", R.string.bottom_bar_item_2)
    object Counter : Feature("counter", R.string.bottom_bar_item_3)
}