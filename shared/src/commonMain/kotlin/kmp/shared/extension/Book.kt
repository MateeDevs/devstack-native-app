package kmp.shared.extension

import kmp.shared.domain.model.Book
import kmp.shared.infrastructure.local.BookEntity

internal val BookEntity.asDomain
    get() = Book(id, name, author ?: "", pageCount ?: 0)
