package cz.matee.devstack.kmp.android.login.ui

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
import cz.matee.and.core.util.extension.get
import cz.matee.devstack.kmp.android.login.R
import cz.matee.devstack.kmp.android.login.vm.AuthViewModel
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.util.extension.get
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import cz.matee.devstack.kmp.android.shared.util.extension.pushedByIme
import cz.matee.devstack.kmp.shared.base.error.ErrorMessageProvider
import cz.matee.devstack.kmp.shared.base.error.getMessage
import dev.chrisbanes.accompanist.insets.navigationBarsPadding
import dev.chrisbanes.accompanist.insets.statusBarsPadding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch

@Composable
fun RegistrationScreen(navHostController: NavHostController) {
    val authVm = getViewModel<AuthViewModel>()
    val errorMessageProvider = get<ErrorMessageProvider>()
    val scope = rememberCoroutineScope()
    val snackBarState = remember { SnackbarHostState() }
    val isLoading by authVm[AuthViewModel.ViewState::loading].collectAsState(initial = false)

    var emailValue by remember { mutableStateOf(TextFieldValue()) }
    var passwordValue by remember { mutableStateOf(TextFieldValue()) }
    var emailError by remember { mutableStateOf(false) }
    var passwordError by remember { mutableStateOf(false) }

    LaunchedEffect(authVm) {
        authVm.errorFlow.collect { error ->
            snackBarState.showSnackbar(errorMessageProvider.getMessage(error))
        }
    }

    fun navigateToLogin() {
        navHostController.popBackStack()
    }

    fun register() {
        emailError = false; passwordError = false

        if (emailValue.text.isEmpty()) emailError = true
        if (passwordValue.text.isEmpty()) passwordError = true

        if (emailError || passwordError) return
        scope.launch {
            if (authVm.register(emailValue.text, "", "", passwordValue.text))
                navigateToLogin()
        }
    }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .statusBarsPadding()
            .padding(horizontal = Values.Space.xlarge)
    ) {
        val passwordFocusRequester = FocusRequester()
        Text(
            text = stringResource(R.string.registration_view_headline_title),
            style = MaterialTheme.typography.h4,
            color = MaterialTheme.colors.primary,
            modifier = Modifier.padding(top = Values.Space.large, bottom = Values.Space.xxlarge)
        )

        OutlinedTextField(
            value = emailValue,
            onValueChange = { emailValue = it },
            label = { Text(stringResource(R.string.registration_view_email_field_hint)) },
            isErrorValue = emailError,
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Email,
                imeAction = ImeAction.Next
            ),
            keyboardActions = KeyboardActions(onNext = { passwordFocusRequester.requestFocus() }),
            modifier = Modifier.padding(bottom = Values.Space.large).fillMaxWidth(),
        )

        OutlinedTextField(
            value = passwordValue,
            onValueChange = { passwordValue = it },
            isErrorValue = passwordError,
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Password,
                imeAction = ImeAction.Done
            ),
            keyboardActions = KeyboardActions(onDone = { register() }),
            label = { Text(stringResource(R.string.registration_view_password_field_hint)) },
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
                SnackbarHost(snackBarState)

                Box(contentAlignment = Alignment.Center) {
                    Button(
                        enabled = !isLoading,
                        onClick = { register() },
                        modifier = Modifier.fillMaxWidth().alpha(if (isLoading) 0.3f else 1f)
                    ) {
                        Text(
                            stringResource(R.string.registration_view_register_button_title),
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

            TextButton(onClick = { navigateToLogin() }) {
                Text(
                    stringResource(R.string.registration_view_login_button_title),
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth()
                )
            }
        }
    }
}