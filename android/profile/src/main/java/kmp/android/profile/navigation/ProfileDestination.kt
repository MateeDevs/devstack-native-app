package kmp.android.profile.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.RootDestination

object ProfileDestination : RootDestination(parent = null) {

    override val path: String = "profile"

    object Home : Destination(parent = this) {
        override val routeDefinition: String = "home"
    }

    object Edit : Destination(parent = this) {
        override val routeDefinition: String = "edit"
    }
}
