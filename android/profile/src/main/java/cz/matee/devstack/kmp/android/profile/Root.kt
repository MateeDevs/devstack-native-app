package cz.matee.devstack.kmp.android.profile

import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import androidx.navigation.compose.composable
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import dev.chrisbanes.accompanist.insets.statusBarsPadding

@Suppress("FunctionName")
fun NavGraphBuilder.ProfileRoot(navHostController: NavHostController) {
    composable(Feature.Profile.route) {
        Text(
            stringResource(Feature.Profile.titleRes),
            style = MaterialTheme.typography.h3,
            modifier = Modifier.statusBarsPadding()
        )
    }
}