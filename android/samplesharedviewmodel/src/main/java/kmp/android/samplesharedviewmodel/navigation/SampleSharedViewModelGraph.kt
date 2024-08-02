package kmp.android.samplesharedviewmodel.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.FeatureGraph

object SampleSharedViewModelGraph : FeatureGraph(parent = null) {

    override val path = "sampleSharedViewModel"

    data object Main : Destination(this) {
        override val routeDefinition: String = "main"
    }
}
