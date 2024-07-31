package kmp.android.sample.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.sample.ui.sampleMainRoute

fun NavGraphBuilder.sampleNavGraph(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = SampleGraph.Main.route,
        route = SampleGraph.rootPath,
    ) {
        sampleMainRoute()
    }
}
