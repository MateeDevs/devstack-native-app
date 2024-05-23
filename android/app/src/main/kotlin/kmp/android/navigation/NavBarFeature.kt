package kmp.android.navigation

import androidx.annotation.StringRes
import kmp.android.books.navigation.BooksGraph
import kmp.android.profile.navigation.ProfileGraph
import kmp.android.recipes.navigation.RecipesGraph
import kmp.android.shared.R
import kmp.android.users.navigation.UsersGraph
import kmp.android.videos.navigation.VideosGraph

enum class NavBarFeature(val route: String, @StringRes val titleRes: Int) {
    Users(UsersGraph.rootPath, R.string.bottom_bar_item_1),
    Profile(ProfileGraph.rootPath, R.string.bottom_bar_item_2),
    Recipes(RecipesGraph.rootPath, R.string.bottom_bar_item_3),
    Books(BooksGraph.rootPath, R.string.bottom_bar_item_4),
    Videos(VideosGraph.rootPath, R.string.bottom_bar_item_5)
}
