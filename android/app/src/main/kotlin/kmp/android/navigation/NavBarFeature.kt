package kmp.android.navigation

import androidx.annotation.StringRes
import kmp.android.books.navigation.BooksDestination
import kmp.android.profile.navigation.ProfileDestination
import kmp.android.recipes.navigation.RecipesDestination
import kmp.android.shared.R
import kmp.android.users.navigation.UsersDestination

enum class NavBarFeature(val route: String, @StringRes val titleRes: Int) {
    Users(UsersDestination.rootPath, R.string.bottom_bar_item_1),
    Profile(ProfileDestination.rootPath, R.string.bottom_bar_item_2),
    Recipes(RecipesDestination.rootPath, R.string.bottom_bar_item_3),
    Books(BooksDestination.rootPath, R.string.bottom_bar_item_4),
}
