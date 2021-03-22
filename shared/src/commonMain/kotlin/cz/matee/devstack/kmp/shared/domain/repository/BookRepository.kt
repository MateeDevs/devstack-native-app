package cz.matee.devstack.kmp.shared.domain.repository

import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.Book
import kotlinx.coroutines.flow.Flow

internal interface BookRepository {
    fun getAllBooks(): Flow<List<Book>>

    suspend fun reloadAllBooks(): Result<Unit>
}