package kmp.shared.core.data.source

import kmp.shared.core.infrastructure.local.BookEntity
import kotlinx.coroutines.flow.Flow

internal interface BookLocalSource {
    fun getAll(): Flow<List<BookEntity>>
    suspend fun updateOrInsert(items: List<BookEntity>)
}
