package kmp.android.shared.navigation

import android.net.Uri
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.runtime.Composable
import androidx.navigation.NamedNavArgument
import androidx.navigation.NavBackStackEntry
import androidx.navigation.NavDeepLink
import androidx.navigation.NavGraphBuilder
import androidx.navigation.compose.composable
import androidx.navigation.compose.dialog
import com.google.accompanist.navigation.material.ExperimentalMaterialNavigationApi
import com.google.accompanist.navigation.material.bottomSheet

/**
 * Base class for navigation graph class.
 */
abstract class FeatureGraph(private val parent: FeatureGraph?) {

    abstract val path: String

    val rootPath: String
        get() = parent?.rootPath?.let { parentPath ->
            if (parentPath.endsWith('/')) {
                "$parentPath$path"
            } else {
                "$parentPath/$path"
            }
        } ?: path
}

/**
 * Base class for any destination the app uses.
 */
abstract class Destination(parent: FeatureGraph?) {
    /**
     * The root id of the destination graph used in the route <root>/<destinationId>/<argument>...
     * In case the parent is null, we do not need any prefix and use the destinationId by itself <destinationId>/<argument>...
     */
    private val parentPath: String = parent?.rootPath?.let { parentRootPath ->
        if (parentRootPath.endsWith('/')) {
            parentRootPath
        } else {
            "$parentRootPath/"
        }
    } ?: ""

    /**
     * The route of the destination, without the root path and nav arguments.
     */
    protected abstract val routeDefinition: String

    open val arguments: List<NamedNavArgument> = emptyList()

    /**
     * Route used to determine this destination from others. Do not use for navigating.
     */
    val route
        get() = constructRoute()

    /**
     * Creates a navigate-able route with the [arguments] provided.
     * @param arguments Arguments that should be used for this destination. The number and order of arguments
     * must exactly match the number and order of arguments this destination requires. For a default value, use null.
     * TODO: It would be nice to ensure correct arguments in correct order are user when constructing the Destination.
     */
    operator fun invoke(vararg arguments: Any?) = constructRouteForNavigation(*arguments)

    /**
     * Constructs a route with argument names in the following format:
     * - e.g. Destination called `detail` with arguments named `id` and `name`:
     *      "detail?id={id}&name={name}"
     * - e.g. Destination called `home` with no arguments:
     *      "home"
     */
    private fun constructRoute() = createUri(
        path = "$parentPath$routeDefinition",
        argList = arguments,
        key = { it.name },
        value = { "{${it.name}}" },
    )

    /**
     * Constructs a route with argument names in the following format:
     * - e.g. Destination called `detail` with arguments named `id` = 5 and `name` = "test":
     *      "detail?id=5&name=test"
     * - e.g. Destination called `home` with no arguments:
     *      "home"
     */
    private fun constructRouteForNavigation(
        vararg routeArguments: Any?,
    ): String {
        require(routeArguments.size == arguments.size) {
            "The routeArgument count must match this destination argument count.\n" +
                "If needed, pass null for default value of argument."
        }
        val args = routeArguments.zip(arguments).map { (routeArg, arg) ->
            // Provided arg or default arg
            val value = (routeArg ?: arg.argument.defaultValue)

            require(value != null || arg.argument.isNullable) {
                "The argument ${arg.name} is null as well as it's default value, but it was not marked as nullable."
            }
            Pair(arg.name, value.toString())
        }

        return createUri(
            path = "$parentPath$routeDefinition",
            argList = args,
            key = { (name, _) -> name },
            value = { (_, value) -> value },
        )
    }

    private fun <T> createUri(
        path: String,
        argList: List<T>,
        key: (T) -> String,
        value: (T) -> String,
    ): String {
        return Uri.Builder()
            .path(path)
            .apply {
                argList.forEach { arg ->
                    appendQueryParameter(key(arg), value(arg))
                }
            }
            .toString()
    }
}

fun NavGraphBuilder.composableDestination(
    destination: Destination,
    deepLinks: List<NavDeepLink> = emptyList(),
    content: @Composable (NavBackStackEntry) -> Unit,
) = composable(
    route = destination.route,
    arguments = destination.arguments,
    deepLinks = deepLinks,
    content = { navBackstackEntry ->
        content(navBackstackEntry)
    },
)

@OptIn(ExperimentalMaterialNavigationApi::class)
fun NavGraphBuilder.bottomSheetDestination(
    destination: Destination,
    content: @Composable ColumnScope.(backstackEntry: NavBackStackEntry) -> Unit,
) = bottomSheet(
    route = destination.route,
    arguments = destination.arguments,
    content = { navBackstackEntry ->
        content(navBackstackEntry)
    },
)

fun NavGraphBuilder.dialogDestination(
    destination: Destination,
    content: @Composable (NavBackStackEntry) -> Unit,
) = dialog(
    route = destination.route,
    arguments = destination.arguments,
    content = { navBackstackEntry ->
        content(navBackstackEntry)
    },
)
