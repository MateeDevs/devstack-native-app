package kmp.android.videos.navigation

import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.FeatureGraph

object VideosGraph : FeatureGraph(parent = null) {
    override val path = "videos"

    data object Add : Destination(this) {
        override val routeDefinition: String = "add"
    }
}