package cz.matee.devstack.kmp.shared.infrastructure.model

import cz.matee.devstack.kmp.shared.domain.model.UserData
import cz.matee.devstack.kmp.shared.domain.model.UserPaging
import kotlinx.serialization.Serializable

@Serializable
data class UserPagingDto(
    val `data`: List<UserDataDto>,
    val lastPage: Int,
    val limit: Int,
    val page: Int
) {
    val asDomain
        get() = UserPaging(
            `data`.map(UserDataDto::asDomain),
            lastPage, limit, page
        )
}

@Serializable
data class UserDataDto(
    val email: String,
    val firstName: String,
    val id: String,
    val lastName: String
) {
    val asDomain get() = UserData(id, email, firstName, lastName)
}