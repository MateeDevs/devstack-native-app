package cz.matee.devstack.kmp.shared.util.extension

import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.model.UserPagingResult
import cz.matee.devstack.kmp.shared.infrastructure.local.UserCache
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDataDto
import cz.matee.devstack.kmp.shared.infrastructure.model.UserPagingDto

// Infrastructure -> Domain

val UserPagingDto.asDomain
    get() = UserPagingResult(
        `data`.map(UserPagingDataDto::asDomain),
        totalCount = totalCount,
        limit = limit,
        offset = page * limit
    )

val UserPagingDataDto.asDomain
    get() = UserPagingData(id, email, firstName, lastName)


// Domain -> Infrastructure

val UserPagingData.asUserCache
    get() = UserCache(id, email, firstName, lastName)