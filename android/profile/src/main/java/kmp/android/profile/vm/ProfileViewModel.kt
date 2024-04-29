package kmp.android.profile.vm

import android.location.Location
import androidx.lifecycle.viewModelScope
import kmp.android.shared.core.system.BaseStateViewModel
import kmp.android.shared.core.system.State
import kmp.android.shared.core.util.launchOnMain
import kmp.android.shared.domain.usecase.GetLocationFlowUseCase
import kmp.shared.base.ErrorResult
import kmp.shared.base.Result
import kmp.shared.base.util.extension.getOrNull
import kmp.shared.domain.model.Book
import kmp.shared.domain.model.User
import kmp.shared.domain.repository.UserUpdateParameters
import kmp.shared.domain.usecase.DeleteAuthDataUseCase
import kmp.shared.domain.usecase.book.GetBooksUseCase
import kmp.shared.domain.usecase.book.RefreshBooksUseCase
import kmp.shared.domain.usecase.user.GetLoggedInUserUseCase
import kmp.shared.domain.usecase.user.UpdateUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.launch

class ProfileViewModel(
    private val getLoggedInUser: GetLoggedInUserUseCase,
    private val deleteAuthData: DeleteAuthDataUseCase,
    private val locationFlow: GetLocationFlowUseCase,
    private val updateUserUc: UpdateUserUseCase,
    private val getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase,
) : BaseStateViewModel<ProfileViewModel.ViewState>(ViewState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>(replay = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    init {
        loadUser()
        loadBooks()
    }

    private fun loadUser() {
        launch {
            loading = true
            getLoggedInUser().collect { res ->
                when (res) {
                    is Result.Success -> update { copy(user = res.data) }
                    is Result.Error -> _errorFlow.emit(res.error)
                }
            }
            loading = false
        }
    }

    private fun loadBooks() {
        launch {
            getBooks().collect { res ->
                update { copy(books = res) }
            }
        }
    }

    fun reloadBooks() {
        viewModelScope.launch {
            when (val res = refreshBooks(10)) {
                is Result.Error -> _errorFlow.emit(res.error)
                is Result.Success -> {
                    // Do nothing
                }
            }
        }
    }

    fun updateUser(user: User) {
        launch {
            loading = true
            val params = UserUpdateParameters(
                user.id,
                firstName = user.firstName
                    .takeIf { user.firstName != lastState().user?.firstName },
                lastName = user.lastName
                    .takeIf { user.lastName != lastState().user?.lastName },
                bio = user.bio
                    .takeIf { user.bio != lastState().user?.bio },
                phone = user.phone
                    .takeIf { user.phone != lastState().user?.phone },
            )

            when (val res = updateUserUc(params)) {
                is Result.Success -> update { copy(user = res.data) }
                is Result.Error -> _errorFlow.emit(res.error)
            }
            loading = false
        }
    }

    fun logOut(openLogin: () -> Unit) {
        launchOnMain {
            deleteAuthData()
            openLogin()
        }
    }

    suspend fun getLocationFlow(): Flow<Location> =
        locationFlow().getOrNull() ?: flowOf()

    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(
        val user: User? = null,
        val books: List<Book> = listOf(),
        val loading: Boolean = false,
    ) : State
}
