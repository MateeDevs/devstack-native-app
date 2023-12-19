package kmp.android.login.navigation

import kmp.android.shared.navigation.Destination

data object LoginDestination : Destination(parent = null) {

    override val routeDefinition: String = "login"
}
