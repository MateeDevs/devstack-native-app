package kmp.android.samplecomposemultiplatform.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.FeatureGraph

object SampleComposeMultiplatformGraph : FeatureGraph(parent = null) {

    override val path = "sampleComposeMultiplatform"

    data object Main : Destination(this) {
        override val routeDefinition: String = "main"
    }
}
