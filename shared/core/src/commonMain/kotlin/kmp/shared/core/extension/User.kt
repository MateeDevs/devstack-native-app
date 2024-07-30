package kmp.shared.core.extension

import kmp.shared.core.domain.model.User
import kmp.shared.core.infrastructure.local.UserEntity
import kmp.shared.core.infrastructure.model.UserDto

// Infrastructure -> Domain

internal val UserEntity.asDomain
    get() = User(id, email, bio ?: "", firstName ?: "", lastName ?: "", phone)

internal val UserDto.asDomain
    get() = User(id, email, bio, firstName, lastName, phone)

// Domain -> Infrastructure

internal val User.asEntity
    get() = UserEntity(id, email, firstName, lastName, phone, bio)

// Helpers

val User.fullName
    get() = "$firstName $lastName"
