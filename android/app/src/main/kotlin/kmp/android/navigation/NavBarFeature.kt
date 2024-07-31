package kmp.android.navigation

import androidx.annotation.StringRes
import kmp.android.sample.navigation.SampleGraph
import kmp.android.shared.R

enum class NavBarFeature(val route: String, @StringRes val titleRes: Int) {
    Sample(SampleGraph.rootPath, R.string.bottom_bar_item_1),
}
