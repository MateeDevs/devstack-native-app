package kmp.android.recipes.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.RootDestination

object RecipesDestination : RootDestination {
    override val route: String = "recipes"

    object List : Destination(this) {
        override val destinationId: String = "list"
    }

    object Rope : Destination(this) {
        override val destinationId: String = "rope"
    }

    object CanvasClock : Destination(this) {
        override val destinationId: String = "clock"
    }

    object ListTransition : Destination(this) {
        override val destinationId: String = "transition-list"
    }
}
