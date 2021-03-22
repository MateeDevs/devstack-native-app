package cz.matee.devstack.kmp.shared.data.source

import cz.matee.devstack.kmp.shared.infrastructure.local.BookEntity
import kotlinx.coroutines.flow.Flow

internal interface BookLocalSource {
    fun getAll(): Flow<List<BookEntity>>
    suspend fun updateOrInsert(items: List<BookEntity>)
}