package kmp.shared.infrastructure.remote

import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.request.get
import io.ktor.client.request.put
import io.ktor.client.request.setBody
import kmp.shared.base.Result
import kmp.shared.base.error.util.runCatchingCommonNetworkExceptions
import kmp.shared.data.source.UserUpdateRequest
import kmp.shared.infrastructure.model.UserDto
import kmp.shared.infrastructure.model.UserPagingDto

internal object UserPaths {
    private const val root = "/api/user"
    const val users = root
    fun user(id: String) = "$root/$id"
}

internal class UserService(private val client: HttpClient) {

    suspend fun getUsers(
        page: Int,
        limit: Int,
    ): Result<UserPagingDto> {
        return runCatchingCommonNetworkExceptions {
            client.get(UserPaths.users) {
                url {
                    parameters["page"] = page.toString()
                    parameters["limit"] = limit.toString()
                }
            }.body()
        }
    }

    suspend fun getUserById(userId: String): Result<UserDto> {
        return runCatchingCommonNetworkExceptions {
            client.get(UserPaths.user(userId)).body()
        }
    }

    suspend fun updateUser(userId: String, body: UserUpdateRequest): Result<UserDto> {
        return runCatchingCommonNetworkExceptions {
            client.put(UserPaths.user(userId)) {
                setBody(
                    buildMap {
                        body.pass?.also { put(UserUpdateRequest::pass.name, it) }
                        body.firstName?.also { put(UserUpdateRequest::firstName.name, it) }
                        body.lastName?.also { put(UserUpdateRequest::lastName.name, it) }
                        body.bio?.also { put(UserUpdateRequest::bio.name, it) }
                        body.phone?.also { put(UserUpdateRequest::phone.name, it) }
                    },
                )
            }.body()
        }
    }
}
