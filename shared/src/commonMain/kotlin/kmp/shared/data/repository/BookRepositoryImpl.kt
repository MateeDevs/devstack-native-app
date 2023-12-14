package kmp.shared.data.repository

import kmp.shared.base.Result
import kmp.shared.data.source.BookLocalSource
import kmp.shared.domain.model.Book
import kmp.shared.domain.repository.BookRepository
import kmp.shared.extension.asDomain
import kmp.shared.infrastructure.local.BookEntity
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.map
import kotlin.random.Random
import kotlin.random.nextInt
import kotlin.random.nextLong

internal class BookRepositoryImpl(
    private val source: BookLocalSource,
) : BookRepository {
    override fun getAllBooks(): Flow<List<Book>> {
        return source.getAll().map { it.map(BookEntity::asDomain) }
    }

    override suspend fun reloadAllBooks(): Result<Unit> {
        val items = List(100) {
            BookEntity(
                Random.nextInt().toString(),
                "Book ${Random.nextInt(1000..9000)}",
                "Author ${Random.nextInt(1000..9000)}",
                Random.nextLong(0..200L),
            )
        }

        source.updateOrInsert(items)
        return Result.Success(Unit)
    }
}
