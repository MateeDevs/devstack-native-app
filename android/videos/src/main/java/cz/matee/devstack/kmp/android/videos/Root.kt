package cz.matee.devstack.kmp.android.videos

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import androidx.navigation.compose.navigation
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.videos.navigation.VideosDestinations
import cz.matee.devstack.kmp.android.videos.ui.VideosAddScreen

@Suppress("FunctionName")
fun NavGraphBuilder.VideosRoot(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = VideosDestinations.Add.route,
        route = Feature.Videos.route,
    ) {
        composable(VideosDestinations.Add.route) {
            VideosAddScreen()
        }
    }
}
