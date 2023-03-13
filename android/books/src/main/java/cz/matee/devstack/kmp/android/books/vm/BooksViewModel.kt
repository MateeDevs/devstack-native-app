package cz.matee.devstack.kmp.android.books.vm

import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.android.shared.vm.VmIntent
import cz.matee.devstack.kmp.android.shared.vm.VmState
import cz.matee.devstack.kmp.android.shared.vm.IntentViewModel
import cz.matee.devstack.kmp.android.shared.vm.intentFlow
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.usecase.book.GetBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kotlinx.coroutines.launch

data class BooksState(
    val isLoading: Boolean = false,
    val books: List<Book> = emptyList(),
    val error: ErrorResult? = null,
) : VmState

class BooksViewModel(
    getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase
) : IntentViewModel<BooksState, BooksIntent>(BooksState()) {

    init {
        intentFlow(getBooks, BooksIntent::OnDataLoaded)
    }

    override fun BooksState.applyIntent(intent: BooksIntent) = when (intent) {
        BooksIntent.LoadData -> loadData()
        is BooksIntent.OnDataLoaded -> this.copy(books = intent.books, isLoading = false)
        is BooksIntent.OnError -> this.copy(error = error)
    }

    private fun BooksState.loadData(): BooksState {
        viewModelScope.launch { refreshBooks(0) }
        return copy(isLoading = true)
    }
}

sealed interface BooksIntent : VmIntent {
    object LoadData : BooksIntent
    data class OnDataLoaded(val books: List<Book>) : BooksIntent
    data class OnError(val error: ErrorResult) : BooksIntent
}

