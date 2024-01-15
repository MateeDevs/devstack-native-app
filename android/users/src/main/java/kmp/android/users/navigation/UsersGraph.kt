package kmp.android.users.navigation

import android.os.Bundle
import androidx.navigation.NamedNavArgument
import androidx.navigation.NavType
import androidx.navigation.navArgument
import kmp.android.shared.navigation.Destination
import kmp.android.shared.navigation.FeatureGraph

object UsersGraph : FeatureGraph(parent = null) {

    override val path: String = "users"

    data object List : Destination(this) {
        override val routeDefinition: String = "list"
    }

    data object Detail : Destination(this) {
        override val routeDefinition: String = "detail"
        internal const val UserIdArg = "userId"
        override val arguments: kotlin.collections.List<NamedNavArgument> = listOf(
            navArgument(UserIdArg) {
                type = NavType.StringType
            },
        )

        internal class Args(
            val userId: String,
        ) {
            constructor(arguments: Bundle?) : this(
                requireNotNull(arguments?.getString(UserIdArg)),
            )
        }
    }
}
