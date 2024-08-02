package kmp.android.sample.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.sample.ui.sampleMainRoute
import kmp.shared.samplesharedviewmodel.vm.SampleSharedViewModel

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
