package cz.matee.devstack.kmp.android.videos.navigation

import androidx.annotation.StringRes

sealed class VideosDestinations(val route: String, @StringRes val titleRes: Int) {
    object Add : VideosDestinations(
        "videos/add",
        cz.matee.devstack.kmp.android.shared.R.string.title_videos,
    )
}
