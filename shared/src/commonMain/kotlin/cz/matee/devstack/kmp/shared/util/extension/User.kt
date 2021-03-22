package cz.matee.devstack.kmp.shared.util.extension

import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity
import cz.matee.devstack.kmp.shared.infrastructure.model.UserDto

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