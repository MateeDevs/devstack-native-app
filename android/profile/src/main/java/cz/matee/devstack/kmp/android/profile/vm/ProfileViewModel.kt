package cz.matee.devstack.kmp.android.profile.vm

import androidx.navigation.NavHostController
import androidx.navigation.compose.navigate
import cz.matee.and.core.system.BaseStateViewModel
import cz.matee.and.core.system.State
import cz.matee.and.core.util.extension.launchOnMain
import cz.matee.devstack.kmp.android.shared.domain.usecase.GetLocationFlowUseCase
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.shared.base.ErrorResult
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.domain.model.User
import cz.matee.devstack.kmp.shared.domain.repository.UserUpdateParameters
import cz.matee.devstack.kmp.shared.domain.usecase.DeleteAuthDataUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.GetLoggedInUserUseCase
import cz.matee.devstack.kmp.shared.domain.usecase.UpdateUserUseCase
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.map

class ProfileViewModel(
    private val getLoggedInUser: GetLoggedInUserUseCase,
    private val deleteAuthData: DeleteAuthDataUseCase,
    private val locationFlow: GetLocationFlowUseCase,
    private val updateUserUc: UpdateUserUseCase
) : BaseStateViewModel<ProfileViewModel.ViewState>(ViewState()) {

    private val _errorFlow = MutableSharedFlow<ErrorResult>(replay = 1)
    val errorFlow: Flow<ErrorResult> get() = _errorFlow

    init {
        loadUser()
    }

    fun loadUser() {
        launch {
            loading = true
            getLoggedInUser().map { res ->
                when (res) {
                    is Result.Success -> update { copy(user = res.data) }
                    is Result.Error -> _errorFlow.emit(res.error)
                }
            }.collect()
            loading = false
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

    suspend fun getLocationFlow() = locationFlow()

    private var loading
        get() = lastState().loading
        set(value) = update { copy(loading = value) }

    data class ViewState(
        val user: User? = null,
        val loading: Boolean = false
    ) : State
}