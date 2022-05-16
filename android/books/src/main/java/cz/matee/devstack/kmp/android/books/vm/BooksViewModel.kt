package cz.matee.devstack.kmp.android.books.vm

import androidx.lifecycle.viewModelScope
import cz.matee.devstack.kmp.android.shared.vm.BaseIntentViewModel
import cz.matee.devstack.kmp.android.shared.vm.VmIntent
import cz.matee.devstack.kmp.android.shared.vm.VmState
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.usecase.book.GetBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.launch

data class BooksState(
    val loading: Boolean = false,
    val books: List<Book> = emptyList()
) : VmState

class BooksViewModel(
    private val getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase
) : BaseIntentViewModel<BooksState, BooksIntent>(BooksState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>()
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    override suspend fun applyIntent(intent: BooksIntent) {
        when (intent) {
            BooksIntent.LoadData -> TODO()
            BooksIntent.ViewDidAppear -> onViewDidAppear()
        }
    }

    private fun onViewDidAppear() {
        observeData()
        periodicallyReloadData()
    }

    private fun observeData() {
        viewModelScope.launch(Dispatchers.IO) {
            getBooks().collect {
                state = state.copy(books = it)
            }
        }
    }

    private fun periodicallyReloadData() {
        viewModelScope.launch(Dispatchers.IO) {
            while (true) {
                state = state.copy(loading = true)
                refreshBooks(2)
                delay(2_000)
                state = state.copy(loading = false)
                delay(10_000)
            }
        }
    }
}

sealed interface BooksIntent : VmIntent {
    object LoadData : BooksIntent
    object ViewDidAppear : BooksIntent
}

