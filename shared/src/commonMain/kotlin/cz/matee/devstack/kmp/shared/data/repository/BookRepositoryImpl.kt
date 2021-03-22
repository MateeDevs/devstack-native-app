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

internal class BookRepositoryImpl(
    private val source: BookLocalSource
) : BookRepository {
    override fun getAllBooks(): Flow<List<Book>> {
        return source.getAll().map { it.map(BookEntity::asDomain) }
    }

    override suspend fun reloadAllBooks(): Result<Unit> {
        val items = mutableListOf<BookEntity>().apply {
            for (i in 1..100) {
                add(
                    BookEntity(
                        Random.nextInt().toString(),
                        "name_${Random.nextInt()}",
                        "author_${Random.nextInt()}",
                        Random.nextInt().toLong()
                    )
                )
            }
        }
        source.updateOrInsert(items)
        return Result.Success(Unit);
    }
}