package cz.matee.devstack.kmp.shared.infrastructure.source

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.data.source.UserRemoteSource
import cz.matee.devstack.kmp.shared.data.source.UserUpdateRequest
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto
import cz.matee.devstack.kmp.shared.infrastructure.remote.UserService

internal class UserRemoteSourceImpl(private val service: UserService) : UserRemoteSource {

    override suspend fun getUsers(paging: UserPagingRequest): Result<UserPagingDto> =
        service.getUsers(paging.offset / paging.limit, paging.limit)

    override suspend fun getUser(id: String): Result<UserDto> =
        service.getUserById(id)

    override suspend fun updateUser(id: String, updateRequest: UserUpdateRequest): Result<UserDto> =
        service.updateUser(id, updateRequest)
}