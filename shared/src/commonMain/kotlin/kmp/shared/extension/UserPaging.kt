package kmp.shared.extension

import kmp.shared.domain.model.UserPagingData
import kmp.shared.domain.model.UserPagingResult
import kmp.shared.infrastructure.local.UserCache
import kmp.shared.infrastructure.model.UserPagingDataDto
import kmp.shared.infrastructure.model.UserPagingDto

// Infrastructure -> Domain

internal val UserPagingDto.asDomain
    get() = UserPagingResult(
        `data`.map(UserPagingDataDto::asDomain),
        totalCount = totalCount,
        limit = limit,
        offset = page * limit,
    )

internal val UserPagingDataDto.asDomain
    get() = UserPagingData(id, email, firstName, lastName)

// Domain -> Infrastructure

internal val UserPagingData.asUserCache
    get() = UserCache(id, email, firstName, lastName)
