package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.base.error.util.runCatchingCommonNetworkExceptions
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.data.source.UserUpdateRequest
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto
import io.ktor.client.HttpClient
import io.ktor.client.request.*

internal object UserPaths {
    private const val root = "/user"
    const val users = root
    fun user(id: String) = "$root/$id"
}


internal class UserService(private val client: HttpClient) {

    suspend fun getUsers(page: Int, limit: Int) = runCatchingCommonNetworkExceptions {
        client.get<UserPagingDto>(path = UserPaths.users) {
            url {
                parameters["page"] = page.toString()
                parameters["limit"] = limit.toString()
            }
        } resultsTo Success
    }

    suspend fun getUserById(userId: String) = runCatchingCommonNetworkExceptions {
        client.get<UserDto>(path = UserPaths.user(userId)) resultsTo Success
    }

    @OptIn(ExperimentalStdlibApi::class)
    suspend fun updateUser(userId: String, body: UserUpdateRequest) =
        runCatchingCommonNetworkExceptions {
            client.put<UserDto>(
                path = UserPaths.user(userId),
                body = buildMap<String, String> {
                    body.pass?.also { put(UserUpdateRequest::pass.name, it) }
                    body.firstName?.also { put(UserUpdateRequest::firstName.name, it) }
                    body.lastName?.also { put(UserUpdateRequest::lastName.name, it) }
                    body.bio?.also { put(UserUpdateRequest::bio.name, it) }
                    body.phone?.also { put(UserUpdateRequest::phone.name, it) }
                }
            ) resultsTo Success
        }

}