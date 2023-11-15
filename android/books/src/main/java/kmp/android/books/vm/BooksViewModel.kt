package kmp.android.books.vm

import kmp.android.shared.vm.BaseIntentViewModel
import kmp.android.shared.vm.VmIntent
import kmp.android.shared.vm.VmState
import kmp.shared.base.ErrorResult
import kmp.shared.domain.usecase.book.GetBooksUseCase
import kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

data class BooksState(
    val loading: Boolean = false,
) : VmState

class BooksViewModel(
    private val getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase,
) : BaseIntentViewModel<BooksState, BooksIntent>(BooksState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>()
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    override suspend fun applyIntent(intent: BooksIntent) {
        TODO("Not yet implemented")
    }
}

sealed interface BooksIntent : VmIntent {
    object LoadData : BooksIntent
}
