package kmp.android.samplesharedviewmodel.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.samplesharedviewmodel.ui.sampleSharedViewModelMainRoute

fun NavGraphBuilder.sampleSharedViewModelNavGraph(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = SampleSharedViewModelGraph.Main.route,
        route = SampleSharedViewModelGraph.rootPath,
    ) {
        sampleSharedViewModelMainRoute()
    }
}
