package cz.matee.devstack.kmp.shared.util.extension

import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity

val UserEntity.asDomain
    get() = User(id, email, bio ?: "", firstName ?: "", lastName ?: "", phone)

val User.asEntity
    get() = UserEntity(id, email, firstName, lastName, phone, bio)