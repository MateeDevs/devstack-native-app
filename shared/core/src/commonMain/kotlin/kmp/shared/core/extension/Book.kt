package kmp.shared.core.extension

import kmp.shared.core.domain.model.Book
import kmp.shared.core.infrastructure.local.BookEntity

internal val BookEntity.asDomain
    get() = Book(id, name, author ?: "", pageCount ?: 0)
