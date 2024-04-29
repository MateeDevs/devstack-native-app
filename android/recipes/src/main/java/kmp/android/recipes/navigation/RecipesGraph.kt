package kmp.android.recipes.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.FeatureGraph

object RecipesGraph : FeatureGraph(parent = null) {

    override val path: String = "recipes"

    object List : Destination(this) {
        override val routeDefinition: String = "list"
    }

    object Rope : Destination(this) {
        override val routeDefinition: String = "rope"
    }

    object CanvasClock : Destination(this) {
        override val routeDefinition: String = "clock"
    }

    object ListTransition : Destination(this) {
        override val routeDefinition: String = "transition-list"
    }
}
