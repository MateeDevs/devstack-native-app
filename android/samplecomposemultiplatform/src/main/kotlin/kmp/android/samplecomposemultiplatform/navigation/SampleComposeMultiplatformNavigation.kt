package kmp.android.samplecomposemultiplatform.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.samplecomposemultiplatform.ui.sampleComposeMultiplatformMainRoute

fun NavGraphBuilder.sampleComposeMultiplatformNavGraph(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = SampleComposeMultiplatformGraph.Main.route,
        route = SampleComposeMultiplatformGraph.rootPath,
    ) {
        sampleComposeMultiplatformMainRoute()
    }
}
