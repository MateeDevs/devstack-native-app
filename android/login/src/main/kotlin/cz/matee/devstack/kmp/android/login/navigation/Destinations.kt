package cz.matee.devstack.kmp.android.login.navigation

import androidx.annotation.StringRes
import cz.matee.devstack.kmp.android.login.R

sealed class LoginDestination(val route: String, @StringRes val titleRes: Int) {
    object Login : LoginDestination("login/login", R.string.login_view_headline_title)
    object Registration :
        LoginDestination("login/registration", R.string.registration_view_headline_title)
}