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
) : IntentViewModel<BooksState, BooksModel, BooksIntent, BooksEvent>(
    initialState = BooksState(),
    initialModel = BooksModel(),
) {

    init {
        intentFlow(producer = getBooks, intent = BooksIntent::OnDataLoaded)
    }

    override fun BooksState.applyIntent(intent: BooksIntent): ReducedState<BooksState, BooksEvent> =
        when (intent) {
            BooksIntent.LoadData -> loadData()
            is BooksIntent.OnDataLoaded -> ReducedState(
                this.copy(books = intent.books),
                BooksEvent.DataLoaded
            )

            is BooksIntent.OnError -> ReducedState(this.copy(error = error), BooksEvent.Error)
        }

    private fun BooksState.loadData(): ReducedState<BooksState, BooksEvent> {
        viewModelScope.launch { refreshBooks(0) }
        return ReducedState(this, BooksEvent.LoadingStarted)
    }

    override fun BooksState.applyEvent(event: BooksEvent): BooksModel = when (event) {
        is BooksEvent.DataLoaded -> BooksModel(
            books = books,
            error = null,
        )

        is BooksEvent.Error -> BooksModel(
            books = books,
            error = error,
        )

        is BooksEvent.LoadingStarted -> BooksModel(
            books = books,
            isLoading = true,
            error = error,
        )
    }
}

data class BooksState(
    val books: List<Book> = emptyList(),
    val error: ErrorResult? = null,
) : VmState

data class BooksModel(
    val books: List<Book> = emptyList(),
    val isLoading: Boolean = false,
    val error: ErrorResult? = null,
) : VmModel

sealed interface BooksEvent : ReducerEvent {
    object DataLoaded : BooksEvent
    object Error : BooksEvent
    object LoadingStarted : BooksEvent
}

sealed interface BooksIntent : VmIntent {
    object LoadData : BooksIntent
    data class OnDataLoaded(val books: List<Book>) : BooksIntent
    data class OnError(val error: ErrorResult) : BooksIntent
}

