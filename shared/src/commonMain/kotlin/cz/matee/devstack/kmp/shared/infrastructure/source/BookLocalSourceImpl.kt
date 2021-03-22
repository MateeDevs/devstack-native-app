package cz.matee.devstack.kmp.shared.infrastructure.source

import com.squareup.sqldelight.runtime.coroutines.asFlow
import com.squareup.sqldelight.runtime.coroutines.mapToList
import cz.matee.devstack.kmp.shared.data.source.BookLocalSource
import cz.matee.devstack.kmp.shared.infrastructure.local.BookEntity
import cz.matee.devstack.kmp.shared.infrastructure.local.BookQueries
import kotlinx.coroutines.flow.Flow

internal class BookLocalSourceImpl(
    private val queries: BookQueries
) : BookLocalSource {
    override fun getAll(): Flow<List<BookEntity>> {
        return queries.getAllBooks().asFlow().mapToList()
    }

    override suspend fun updateOrInsert(items: List<BookEntity>) {
        queries.deleteAllBooks()
        items.forEach(queries::insertOrReplace)
    }
}