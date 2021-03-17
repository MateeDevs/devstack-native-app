package cz.matee.devstack.kmp.android.login.ui

import androidx.compose.animation.Crossfade
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigate
import cz.matee.and.core.util.extension.get
import cz.matee.devstack.kmp.android.login.R
import cz.matee.devstack.kmp.android.login.vm.AuthViewModel
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.util.composition.OverrideNavigationBackPressDispatcher
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.shared.util.extension.pushedByIme
import cz.matee.devstack.kmp.android.shared.util.extension.showIn
import dev.chrisbanes.accompanist.insets.navigationBarsPadding
import dev.chrisbanes.accompanist.insets.statusBarsPadding
import kotlinx.coroutines.launch
import cz.matee.devstack.kmp.android.login.vm.AuthViewModel.ViewState as LoginViewModelState

@Composable
fun AuthScreen(navHostController: NavHostController) {
    val authVm = getViewModel<AuthViewModel>()
    val scope = rememberCoroutineScope()
    val snackBarState = remember { SnackbarHostState() }
    val loginState = remember { AuthState() }
    val registerState = remember { AuthState() }
    var authScreen by remember { mutableStateOf(AuthScreen.Login) }
    val isLoading by authVm[LoginViewModelState::loading].collectAsState(initial = false)

    authVm.errorFlow showIn snackBarState

    if (authScreen == AuthScreen.Registration)
        OverrideNavigationBackPressDispatcher(navHostController) {
            authScreen = AuthScreen.Login
        }

    fun onAction() {
        val state = when (authScreen) {
            AuthScreen.Login -> loginState
            AuthScreen.Registration -> registerState
        }

        state.updateErrorStates()
        if (state.hasErrors) return

        scope.launch {
            when (authScreen) {
                AuthScreen.Login ->
                    if (authVm.login(state.emailValue.text, state.passwordValue.text))
                        navHostController.navigate(Feature.Users.route)

                AuthScreen.Registration ->
                    if (authVm.register(state.emailValue.text, state.passwordValue.text))
                        authScreen = AuthScreen.Login

            }
        }
    }

    fun onScreenSwitch() {
        authScreen = when (authScreen) {
            AuthScreen.Login -> AuthScreen.Registration
            AuthScreen.Registration -> AuthScreen.Login
        }
    }

    Crossfade(authScreen) {
        AuthForm(
            screen = it,
            state = if (it == AuthScreen.Login) loginState else registerState,
            snackBarState = snackBarState,
            isLoading = isLoading,
            onAction = { onAction() },
            onScreenSwitch = { onScreenSwitch() }
        )
    }

}

@Composable
private fun AuthForm(
    screen: AuthScreen,
    state: AuthState,
    snackBarState: SnackbarHostState,
    isLoading: Boolean,
    onAction: () -> Unit,
    onScreenSwitch: () -> Unit
) {
    val titleText = stringResource(
        if (screen == AuthScreen.Login) R.string.login_view_headline_title
        else R.string.registration_view_headline_title
    )
    val emailLabel = stringResource(
        if (screen == AuthScreen.Login) R.string.login_view_email_field_hint
        else R.string.registration_view_email_field_hint
    )
    val passwordLabel = stringResource(
        if (screen == AuthScreen.Login) R.string.login_view_password_field_hint
        else R.string.registration_view_password_field_hint
    )
    val actionBtnText = stringResource(
        if (screen == AuthScreen.Login) R.string.login_view_login_button_title
        else R.string.registration_view_register_button_title
    )
    val navigateBtn = stringResource(
        if (screen == AuthScreen.Login) R.string.login_view_register_button_title
        else R.string.registration_view_login_button_title
    )


    Column(
        modifier = Modifier
            .fillMaxWidth()
            .statusBarsPadding()
            .padding(horizontal = Values.Space.xlarge)
    ) {
        val passwordFocusRequester = FocusRequester()
        Text(
            text = titleText,
            style = MaterialTheme.typography.h4,
            color = MaterialTheme.colors.primary,
            modifier = Modifier.padding(top = Values.Space.large, bottom = Values.Space.xxlarge)
        )

        OutlinedTextField(
            value = state.emailValue,
            onValueChange = { state.emailValue = it },
            label = { Text(emailLabel) },
            isError = state.emailError,
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Email,
                imeAction = ImeAction.Next
            ),
            keyboardActions = KeyboardActions(onNext = { passwordFocusRequester.requestFocus() }),
            modifier = Modifier
                .padding(bottom = Values.Space.large)
                .fillMaxWidth(),
        )

        OutlinedTextField(
            value = state.passwordValue,
            onValueChange = { state.passwordValue = it },
            label = { Text(passwordLabel) },
            isError = state.passwordError,
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Password,
                imeAction = ImeAction.Done
            ),
            keyboardActions = KeyboardActions(onDone = { onAction() }),
            modifier = Modifier
                .focusRequester(passwordFocusRequester)
                .padding(bottom = Values.Space.large)
                .fillMaxWidth(),
        )

        Column(
            verticalArrangement = Arrangement.Bottom,
            modifier = Modifier
                .fillMaxSize()
                .navigationBarsPadding()
                .padding(bottom = Values.Space.medium)
        ) {

            Column(
                modifier = Modifier
                    .pushedByIme(Values.Space.medium)
                    .padding(bottom = Values.Space.small)
            ) {
                SnackbarHost(snackBarState, Modifier)

                Box(contentAlignment = Alignment.Center) {
                    Button(
                        enabled = !isLoading,
                        onClick = { onAction() },
                        modifier = Modifier
                            .fillMaxWidth()
                            .alpha(if (isLoading) 0.3f else 1f)
                    ) {
                        Text(
                            actionBtnText,
                            style = MaterialTheme.typography.h5,
                            textAlign = TextAlign.Center,
                        )
                    }

                    if (isLoading) CircularProgressIndicator(
                        strokeWidth = Values.Border.mediumLarge,
                        modifier = Modifier.size(30.dp)
                    )
                }
            }

            TextButton(onClick = { onScreenSwitch() }) {
                Text(
                    navigateBtn,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth()
                )
            }
        }
    }
}

private enum class AuthScreen { Login, Registration }

@Stable
private class AuthState {
    var emailValue by mutableStateOf(TextFieldValue())
    var passwordValue by mutableStateOf(TextFieldValue())
    var emailError by mutableStateOf(false)
    var passwordError by mutableStateOf(false)

    val hasErrors get() = emailError || passwordError

    fun updateErrorStates() {
        emailError = emailValue.text.isEmpty()
        passwordError = passwordValue.text.isEmpty()
    }
}