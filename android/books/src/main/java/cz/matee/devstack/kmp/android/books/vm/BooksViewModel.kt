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
) : IntentViewModel<BooksState, BooksModel, BooksIntent, BooksMessage>(
    initialState = BooksState(),
    initialModel = BooksModel(),
) {

    init {
        intentFlow(producer = getBooks, intent = BooksIntent::OnDataLoaded)
    }

    override fun BooksState.applyIntent(intent: BooksIntent): ReducedState<BooksState, BooksMessage> =
        when (intent) {
            BooksIntent.LoadData -> loadData()
            is BooksIntent.OnDataLoaded -> ReducedState(
                this.copy(books = intent.books),
                BooksMessage.DataLoaded
            )

            is BooksIntent.OnError -> ReducedState(this.copy(error = error), BooksMessage.Error)
        }

    private fun BooksState.loadData(): ReducedState<BooksState, BooksMessage> {
        viewModelScope.launch { refreshBooks(0) }
        return ReducedState(this, BooksMessage.LoadingStarted)
    }

    override fun BooksState.applyMessage(message: BooksMessage): BooksModel = when (message) {
        is BooksMessage.DataLoaded -> BooksModel(
            books = books,
            error = null,
        )

        is BooksMessage.Error -> BooksModel(
            books = books,
            error = error,
        )

        is BooksMessage.LoadingStarted -> BooksModel(
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

sealed interface BooksMessage : ReducerMessage {
    object DataLoaded : BooksMessage
    object Error : BooksMessage
    object LoadingStarted : BooksMessage
}

sealed interface BooksIntent : VmIntent {
    object LoadData : BooksIntent
    data class OnDataLoaded(val books: List<Book>) : BooksIntent
    data class OnError(val error: ErrorResult) : BooksIntent
}

