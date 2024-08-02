package kmp.android.navigation

import androidx.annotation.StringRes
import kmp.android.sample.navigation.SampleGraph
import kmp.android.samplecomposemultiplatform.navigation.SampleComposeMultiplatformGraph
import kmp.android.samplesharedviewmodel.navigation.SampleSharedViewModelGraph
import kmp.android.shared.R

enum class NavBarFeature(val route: String, @StringRes val titleRes: Int) {
    Sample(SampleGraph.rootPath, R.string.bottom_bar_item_1),
    SampleSharedViewModel(SampleSharedViewModelGraph.rootPath, R.string.bottom_bar_item_2),
    SampleComposeMultiplatform(SampleComposeMultiplatformGraph.rootPath, R.string.bottom_bar_item_3),
}
