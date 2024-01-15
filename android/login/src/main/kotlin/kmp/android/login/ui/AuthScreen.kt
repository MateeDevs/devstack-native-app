package kmp.android.login.ui

import androidx.compose.animation.Crossfade
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.navigationBarsPadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.statusBarsPadding
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.Button
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.MaterialTheme
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.SnackbarHost
import androidx.compose.material.SnackbarHostState
import androidx.compose.material.Text
import androidx.compose.material.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.Stable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
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
import androidx.navigation.NavController
import androidx.navigation.NavGraphBuilder
import androidx.navigation.NavHostController
import kmp.android.login.navigation.LoginDestination
import kmp.android.login.vm.AuthViewModel
import kmp.android.shared.R
import kmp.android.shared.core.ui.util.BackPressOverride
import kmp.android.shared.core.util.get
import kmp.android.shared.extension.pushedByIme
import kmp.android.shared.extension.showIn
import kmp.android.shared.navigation.composableDestination
import kmp.android.shared.style.Values
import kotlinx.coroutines.launch
import org.koin.androidx.compose.getViewModel
import kmp.android.login.vm.AuthViewModel.ViewState as LoginViewModelState

internal fun NavGraphBuilder.authRoute(
    navHostController: NavHostController,
    navigateToUsers: () -> Unit,
) {
    composableDestination(
        destination = LoginDestination,
    ) {
        AuthRoute(
            navHostController = navHostController,
            navigateToUsers = navigateToUsers,
        )
    }
}

@Composable
internal fun AuthRoute(
    navHostController: NavHostController,
    navigateToUsers: () -> Unit,
    viewModel: AuthViewModel = getViewModel(),
) {
    val isLoading by viewModel[LoginViewModelState::loading].collectAsState(initial = false)
    val scope = rememberCoroutineScope()
    val snackBarState = remember { SnackbarHostState() }
    val loginState =
        remember {
            AuthState().apply {
                emailValue = TextFieldValue("petr.chmelar@matee.cz")
                passwordValue = TextFieldValue("11111111")
            }
        }
    val registerState = remember { AuthState() }
    var authScreen by remember { mutableStateOf(AuthScreen.Login) }

    viewModel.errorFlow showIn snackBarState

    if (authScreen == AuthScreen.Registration) {
        BackPressOverride(navHostController) {
            authScreen = AuthScreen.Login
        }
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
                    if (viewModel.login(state.emailValue.text, state.passwordValue.text)) {
                        navigateToUsers()
                    }

                AuthScreen.Registration ->
                    if (viewModel.register(state.emailValue.text, state.passwordValue.text)) {
                        authScreen = AuthScreen.Login
                    }
            }
        }
    }

    fun onScreenSwitch() {
        authScreen = when (authScreen) {
            AuthScreen.Login -> AuthScreen.Registration
            AuthScreen.Registration -> AuthScreen.Login
        }
    }

    AuthScreen(
        isLoading = isLoading,
        authScreen = authScreen,
        authState = { if (it == AuthScreen.Login) loginState else registerState },
        snackBarState = snackBarState,
        onAction = ::onAction,
        onScreenSwitch = ::onScreenSwitch,
    )
}

@Composable
private fun AuthScreen(
    isLoading: Boolean,
    authScreen: AuthScreen,
    authState: (AuthScreen) -> AuthState,
    snackBarState: SnackbarHostState,
    onAction: () -> Unit,
    onScreenSwitch: () -> Unit,
    modifier: Modifier = Modifier,
) {
    Crossfade(authScreen, modifier = modifier, label = "AuthFormCrossfade") { screen ->
        AuthForm(
            screen = screen,
            state = authState(screen),
            snackBarState = snackBarState,
            isLoading = isLoading,
            onAction = { onAction() },
            onScreenSwitch = { onScreenSwitch() },
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
    onScreenSwitch: () -> Unit,
) {
    val titleText = stringResource(
        if (screen == AuthScreen.Login) {
            R.string.login_view_headline_title
        } else {
            R.string.registration_view_headline_title
        },
    )
    val emailLabel = stringResource(
        if (screen == AuthScreen.Login) {
            R.string.login_view_email_field_hint
        } else {
            R.string.registration_view_email_field_hint
        },
    )
    val passwordLabel = stringResource(
        if (screen == AuthScreen.Login) {
            R.string.login_view_password_field_hint
        } else {
            R.string.registration_view_password_field_hint
        },
    )
    val actionBtnText = stringResource(
        if (screen == AuthScreen.Login) {
            R.string.login_view_login_button_title
        } else {
            R.string.registration_view_register_button_title
        },
    )
    val navigateBtn = stringResource(
        if (screen == AuthScreen.Login) {
            R.string.login_view_register_button_title
        } else {
            R.string.registration_view_login_button_title
        },
    )

    Column(
        modifier = Modifier
            .fillMaxWidth().statusBarsPadding()
            .padding(horizontal = Values.Space.xlarge),
    ) {
        val passwordFocusRequester = FocusRequester()
        Text(
            text = titleText,
            style = MaterialTheme.typography.h4,
            color = MaterialTheme.colors.primary,
            modifier = Modifier.padding(top = Values.Space.large, bottom = Values.Space.xxlarge),
        )

        OutlinedTextField(
            value = state.emailValue,
            onValueChange = { state.emailValue = it },
            label = { Text(emailLabel) },
            isError = state.emailError,
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Email,
                imeAction = ImeAction.Next,
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
                imeAction = ImeAction.Done,
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
                .padding(bottom = Values.Space.medium),
        ) {
            Column(
                modifier = Modifier
                    .pushedByIme(Values.Space.medium)
                    .padding(bottom = Values.Space.small),
            ) {
                SnackbarHost(snackBarState, Modifier)

                Box(contentAlignment = Alignment.Center) {
                    Button(
                        enabled = !isLoading,
                        onClick = { onAction() },
                        modifier = Modifier
                            .fillMaxWidth()
                            .alpha(if (isLoading) 0.3f else 1f),
                    ) {
                        Text(
                            actionBtnText,
                            style = MaterialTheme.typography.h5,
                            textAlign = TextAlign.Center,
                        )
                    }

                    if (isLoading) {
                        CircularProgressIndicator(
                            strokeWidth = Values.Border.mediumLarge,
                            modifier = Modifier.size(30.dp),
                        )
                    }
                }
            }

            TextButton(onClick = { onScreenSwitch() }) {
                Text(
                    navigateBtn,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth(),
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
