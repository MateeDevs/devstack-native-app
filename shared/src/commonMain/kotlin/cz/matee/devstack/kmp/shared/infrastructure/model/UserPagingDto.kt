package cz.matee.devstack.kmp.shared.infrastructure.model

import cz.matee.devstack.kmp.shared.domain.model.UserPagingData
import cz.matee.devstack.kmp.shared.domain.model.UserPagingResult
import kotlinx.serialization.Serializable

@Serializable
data class UserPagingDto(
    val `data`: List<UserDataDto>,
    val totalCount: Int,
    val lastPage: Int,
    val limit: Int,
    val page: Int
) {
    val asDomain
        get() = UserPagingResult(
            `data`.map(UserDataDto::asDomain),
            totalCount = totalCount,
            limit = limit,
            offset = page * limit
        )
}

@Serializable
data class UserDataDto(
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String
) {
    val asDomain get() = UserPagingData(id, email, firstName, lastName)
}