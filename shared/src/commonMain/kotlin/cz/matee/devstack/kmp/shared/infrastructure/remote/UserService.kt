package cz.matee.devstack.kmp.shared.infrastructure.remote

import cz.matee.devstack.kmp.shared.base.error.util.runCatchingCommonNetworkExceptions
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.data.source.UserUpdateRequest
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto
import io.ktor.client.HttpClient
import io.ktor.client.request.*

object UserPaths {
    private const val root = "/user"
    const val users = root
    fun user(id: String) = "$root/$id"
}


class UserService(private val client: HttpClient) {

    suspend fun getUsers(params: UserPagingRequest) = runCatchingCommonNetworkExceptions {
        client.get<UserPagingDto>(path = UserPaths.users) {
            url {
                parameters["page"] = params.page.toString()
                parameters["limit"] = params.limit.toString()
            }
        } resultsTo Success
    }

    suspend fun getUserById(userId: String) = runCatchingCommonNetworkExceptions {
        client.get<UserDto>(path = UserPaths.user(userId)) resultsTo Success
    }

    suspend fun updateUser(userId: String, body: UserUpdateRequest) =
        runCatchingCommonNetworkExceptions {
            client.put<UserDto>(
                path = UserPaths.user(userId),
                body = body
            ) resultsTo Success
        }

}