package kmp.shared.core.infrastructure.source

import kmp.shared.core.base.Result
import kmp.shared.core.data.source.UserPagingRequest
import kmp.shared.core.data.source.UserRemoteSource
import kmp.shared.core.data.source.UserUpdateRequest
import kmp.shared.core.infrastructure.model.UserDto
import kmp.shared.core.infrastructure.model.UserPagingDto
import kmp.shared.core.infrastructure.remote.UserService

internal class UserRemoteSourceImpl(private val service: UserService) : UserRemoteSource {

    override suspend fun getUsers(paging: UserPagingRequest): Result<UserPagingDto> =
        service.getUsers(paging.offset / paging.limit, paging.limit)

    override suspend fun getUser(id: String): Result<UserDto> =
        service.getUserById(id)

    override suspend fun updateUser(id: String, updateRequest: UserUpdateRequest): Result<UserDto> =
        service.updateUser(id, updateRequest)
}
