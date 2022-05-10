package cz.matee.devstack.kmp.android.books.vm

import cz.matee.devstack.kmp.android.shared.vm.BaseIntentViewModel
import cz.matee.devstack.kmp.android.shared.vm.VmIntent
import cz.matee.devstack.kmp.android.shared.vm.VmState
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.domain.usecase.book.GetBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow

data class BooksState(
    val loading: Boolean = false
) : VmState

class BooksViewModel(
    private val getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase
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

