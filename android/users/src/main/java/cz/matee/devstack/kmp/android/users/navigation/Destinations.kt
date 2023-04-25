package cz.matee.devstack.kmp.android.users.navigation

import androidx.annotation.StringRes
import cz.matee.devstack.kmp.android.users.R

sealed class UsersDestination(val route: String, @StringRes val titleRes: Int) {
    object List : UsersDestination("users/list", cz.matee.devstack.kmp.android.shared.R.string.users_view_toolbar_title)
    object Detail :
        UsersDestination("users/detail/{userId}", cz.matee.devstack.kmp.android.shared.R.string.user_detail_view_toolbar_title) {
        const val userIdArgument = "userId"
        fun withUser(id: String) = "users/detail/$id"
    }
}