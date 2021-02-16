package cz.matee.devstack.kmp.android.shared.util.extension

import androidx.navigation.NavOptionsBuilder
import cz.matee.devstack.kmp.android.shared.R

fun NavOptionsBuilder.defaultAnim() {
    anim {
        enter = R.anim.fragment_fade_enter
        exit = R.anim.fragment_fade_exit
        popEnter = R.anim.fragment_fade_enter
        popExit = R.anim.fragment_fade_exit
    }
}