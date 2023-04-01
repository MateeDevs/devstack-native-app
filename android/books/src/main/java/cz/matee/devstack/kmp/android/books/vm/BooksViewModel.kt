package cz.matee.devstack.kmp.android.books.vm

import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.android.shared.vm.*
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.usecase.book.GetBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kotlinx.coroutines.launch

class BooksViewModel(
    getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase
) : IntentViewModel<BooksState, BooksModel, BooksIntent>(
    initialState = BooksState(),
    initialModel = BooksModel(),
) {

    init {
        intentFlow(producer = getBooks, intent = BooksIntent::OnDataLoaded)
    }

    override fun BooksState.applyIntent(intent: BooksIntent) = when (intent) {
        BooksIntent.LoadData -> loadData()
        is BooksIntent.OnDataLoaded -> this.copy(books = intent.books, isLoading = false)
        is BooksIntent.OnError -> this.copy(error = error)
    }

    override fun mapToModel(state: BooksState): BooksModel {
        return BooksModel(books = state.books, isLoading = false, error = null)
//        when (state) {
//            is BooksState.Loaded -> BooksModel(books = state.books, isLoading = false, error = null)
//            is BooksState.Loading -> BooksModel(isLoading = true)
//            is BooksState.Error -> BooksModel(error = state.error)
//        }
    }

    private fun BooksState.loadData(): BooksState {
        viewModelScope.launch { refreshBooks(0) }
        return copy(isLoading = true, books = emptyList())
    }
}

data class BooksState(
    val books: List<Book> = emptyList(),
    val isLoading: Boolean = false,
    val error: ErrorResult? = null,
) : VmState

data class BooksModel(
    val books: List<Book> = emptyList(),
    val isLoading: Boolean = false,
    val error: ErrorResult? = null,
) : VmModel

sealed interface BooksIntent : VmIntent {
    object LoadData : BooksIntent
    data class OnDataLoaded(val books: List<Book>) : BooksIntent
    data class OnError(val error: ErrorResult) : BooksIntent
}

