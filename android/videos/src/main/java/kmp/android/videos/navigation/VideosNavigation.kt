package kmp.android.videos.navigation

import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigation
import kmp.android.videos.ui.addVideosRoute

fun NavGraphBuilder.videosNavGraph(
    navHostController: NavHostController,
) {
    navigation(
        startDestination = VideosGraph.Add.route,
        route = VideosGraph.rootPath,
    ) {
        addVideosRoute()
    }
}
