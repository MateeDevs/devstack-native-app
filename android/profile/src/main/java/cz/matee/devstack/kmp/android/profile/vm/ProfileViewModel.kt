package cz.matee.devstack.kmp.android.profile.vm

import android.location.Location
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.shared.core.system.BaseStateViewModel
import cz.matee.devstack.kmp.android.shared.core.system.State
import cz.matee.devstack.kmp.android.shared.core.util.launchOnMain
import cz.matee.devstack.kmp.android.shared.domain.usecase.GetLocationFlowUseCase
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.util.extension.getOrNull
import cz.matee.devstack.kmp.shared.domain.model.Book
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserUpdateParameters
import cz.matee.devstack.kmp.shared.domain.usecase.DeleteAuthDataUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.GetBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.book.RefreshBooksUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.user.GetLoggedInUserUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.user.UpdateUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.flowOf

class ProfileViewModel(
    private val getLoggedInUser: GetLoggedInUserUseCase,
    private val deleteAuthData: DeleteAuthDataUseCase,
    private val locationFlow: GetLocationFlowUseCase,
    private val updateUserUc: UpdateUserUseCase,
    private val getBooks: GetBooksUseCase,
    private val refreshBooks: RefreshBooksUseCase
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

    suspend fun reloadBooks() {
        when (val res = refreshBooks(10)) {
            is Result.Error -> _errorFlow.emit(res.error)
            is Result.Success -> {
                // Do nothing
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
                    .takeIf { user.phone != lastState().user?.phone }
            )

            when (val res = updateUserUc(params)) {
                is Result.Success -> update { copy(user = res.data) }
                is Result.Error -> _errorFlow.emit(res.error)
            }
            loading = false
        }
    }

    fun logOut(navHostController: NavHostController) {
        launchOnMain {
            deleteAuthData()
            navHostController.navigate(Feature.Login.route)
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
        val loading: Boolean = false
    ) : State
}