package cz.matee.devstack.kmp.shared.infrastructure.source

import com.squareup.sqldelight.runtime.coroutines.asFlow
import com.squareup.sqldelight.runtime.coroutines.mapToList
import cz.matee.devstack.kmp.shared.data.source.UserLocalSource
import cz.matee.devstack.kmp.shared.data.source.UserPagingRequest
import cz.matee.devstack.kmp.shared.infrastructure.local.UserEntity
import cz.matee.devstack.kmp.shared.infrastructure.local.UserQueries
import kotlinx.coroutines.flow.Flow

class UserLocalSourceImpl(private val userQueries: UserQueries) : UserLocalSource {

    override suspend fun getUsers(paging: UserPagingRequest): Flow<List<UserEntity>> {
        val offset = (paging.page * paging.limit).toLong()
        return userQueries
            .getUsersPaginated(paging.limit.toLong(), offset)
            .asFlow()
            .mapToList()
    }

    override suspend fun getUser(id: String): UserEntity? =
        userQueries
            .getUser(id)
            .executeAsOneOrNull()

    override suspend fun updateOrCreate(user: UserEntity) {
        userQueries.transaction {
            insertOrUpdate(user)
        }
    }

    override suspend fun updateOrCreate(users: List<UserEntity>) {
        userQueries.transaction {
            for (user in users) insertOrUpdate(user)
        }
    }

    override suspend fun getUserCount(): Long = userQueries.getUserCount().executeAsOne()

    private fun insertOrUpdate(user: UserEntity) {
        val local = userQueries.getUser(user.id).executeAsOneOrNull()

        if (local != null)
            userQueries.updateUser(
                user.firstName,
                user.lastName,
                user.phone,
                user.bio,
                user.id
            )
        else userQueries.insertUser(user)
    }
}