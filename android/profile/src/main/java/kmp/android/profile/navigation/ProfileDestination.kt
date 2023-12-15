package kmp.android.profile.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.RootDestination

object ProfileDestination : RootDestination {

    override val route: String = "profile"

    object Home : Destination(parent = this) {
        override val destinationId: String = "home"
    }

    object Edit : Destination(parent = this) {
        override val destinationId: String = "edit"
    }
}
