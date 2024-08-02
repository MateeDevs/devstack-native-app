package kmp.android.ui

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.material.BottomNavigation
import androidx.compose.material.BottomNavigationItem
import androidx.compose.material.Icon
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Scaffold
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.AccountBox
import androidx.compose.material.icons.filled.AccountCircle
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.primarySurface
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import kmp.android.sample.navigation.SampleGraph
import kmp.android.sample.navigation.sampleNavGraph
import kmp.android.navigation.NavBarFeature
import kmp.android.samplecomposemultiplatform.navigation.sampleComposeMultiplatformNavGraph
import kmp.android.samplesharedviewmodel.navigation.sampleSharedViewModelNavGraph
import kmp.android.shared.style.Values

@Composable
fun Root(modifier: Modifier = Modifier) {
    val navController = rememberNavController()

    Scaffold(
        modifier = modifier,
        bottomBar = { BottomBar(navController) },
    ) { padding ->
        Box(modifier = Modifier.padding(padding)) {
            NavHost(
                navController,
                startDestination = SampleGraph.rootPath,
            ) {
                sampleNavGraph(navController)

                sampleSharedViewModelNavGraph(navController)

                sampleComposeMultiplatformNavGraph(navController)
            }
        }
    }
}

@Composable
private fun BottomBar(navController: NavHostController) {
    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    Surface(
        elevation = Values.Elevation.huge,
        color = MaterialTheme.colors.primarySurface,
    ) {
        BottomNavigation(
            Modifier.navigationBarsPadding(),
            elevation = 0.dp,
        ) {
            NavBarFeature.entries.forEach { screen ->
                BottomNavigationItem(
                    icon = {
                        when (screen) {
                            NavBarFeature.Sample -> Icon(Icons.Filled.Person, "")
                            NavBarFeature.SampleSharedViewModel -> Icon(Icons.Filled.AccountCircle, "")
                            NavBarFeature.SampleComposeMultiplatform -> Icon(Icons.Filled.AccountBox, "")
                        }
                    },
                    label = { Text(stringResource(screen.titleRes)) },
                    selected = currentRoute?.startsWith(screen.route + "/") ?: false,
                    onClick = {
                        navController.navigate(screen.route) {
                            popUpTo(navController.graph.startDestinationId)
                            launchSingleTop = true
                        }
                    },
                )
            }
        }
    }
}
