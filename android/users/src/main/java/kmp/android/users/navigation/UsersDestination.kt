package kmp.android.users.navigation

import androidx.annotation.StringRes
import kmp.android.shared.R

sealed class UsersDestination(val route: String, @StringRes val titleRes: Int) {
    object List : UsersDestination("users/list", R.string.users_view_toolbar_title)
    object Detail :
        UsersDestination("users/detail/{userId}", R.string.user_detail_view_toolbar_title) {
        const val userIdArgument = "userId"
        fun withUser(id: String) = "users/detail/$id"
    }
}
