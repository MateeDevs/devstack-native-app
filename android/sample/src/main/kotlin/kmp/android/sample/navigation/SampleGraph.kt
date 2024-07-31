package kmp.android.sample.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.FeatureGraph

object SampleGraph : FeatureGraph(parent = null) {

    override val path = "sample"

    data object Main : Destination(this) {
        override val routeDefinition: String = "main"
    }
}
