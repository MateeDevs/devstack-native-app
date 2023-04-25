package cz.matee.devstack.kmp.shared.data.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.data.source.BookLocalSource
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.repository.BookRepository
import cz.matee.devstack.kmp.shared.infrastructure.local.BookEntity
import cz.matee.devstack.kmp.shared.util.extension.asDomain
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
