package cz.matee.devstack.kmp.android.login.ui

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.focus.FocusRequester
import androidx.compose.ui.focus.focusRequester
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.layout.positionInWindow
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.ImeAction
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.text.input.PasswordVisualTransformation
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.navigation.NavHostController
import androidx.navigation.compose.navigate
import cz.matee.and.core.util.extension.get
import cz.matee.devstack.kmp.android.login.R
import cz.matee.devstack.kmp.android.login.navigation.LoginDestination
import cz.matee.devstack.kmp.android.login.vm.LoginViewModel
import cz.matee.devstack.kmp.android.shared.navigation.Feature
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.util.extension.defaultAnim
import cz.matee.devstack.kmp.android.shared.util.extension.getViewModel
import dev.chrisbanes.accompanist.insets.LocalWindowInsets
import dev.chrisbanes.accompanist.insets.navigationBarsPadding
import dev.chrisbanes.accompanist.insets.statusBarsPadding
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.launch
import kotlin.math.roundToInt
import cz.matee.devstack.kmp.android.login.vm.LoginViewModel.ViewState as LoginState

@Composable
fun LoginScreen(navHostController: NavHostController) {
    val loginVm = getViewModel<LoginViewModel>()
    val scope = rememberCoroutineScope()
    val snackBarState = remember { SnackbarHostState() }
    val isLoading by loginVm[LoginState::loading].collectAsState(initial = false)

    var emailValue by remember { mutableStateOf(TextFieldValue()) }
    var passwordValue by remember { mutableStateOf(TextFieldValue()) }

    LaunchedEffect(loginVm) {
        loginVm.errorFlow.collect { error ->
            snackBarState.showSnackbar(error.message ?: "Unknown error")
        }
    }

    fun login() {
        scope.launch {
            if (loginVm.login(emailValue.text, passwordValue.text))
                navHostController.navigate(Feature.Users.route) { defaultAnim() }
        }
    }

    fun navigateToRegister() {
        navHostController.navigate(LoginDestination.Registration.route) { defaultAnim() }
    }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .statusBarsPadding()
            .padding(horizontal = Values.Space.xlarge)
    ) {
        val passwordFocusRequester = FocusRequester()
        Text(
            text = stringResource(R.string.login_view_headline_title),
            style = MaterialTheme.typography.h4,
            color = MaterialTheme.colors.primary,
            modifier = Modifier.padding(top = Values.Space.large, bottom = Values.Space.xxlarge)
        )

        OutlinedTextField(
            value = emailValue,
            onValueChange = { emailValue = it },
            label = { Text(stringResource(R.string.login_view_email_field_hint)) },
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
            visualTransformation = PasswordVisualTransformation(),
            keyboardOptions = KeyboardOptions(
                keyboardType = KeyboardType.Password,
                imeAction = ImeAction.Done
            ),
            keyboardActions = KeyboardActions(onDone = { login() }),
            label = { Text(stringResource(R.string.login_view_password_field_hint)) },
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

            SnackbarHost(snackBarState, modifier = Modifier.pushedByIme(Values.Space.medium))

            Box(
                contentAlignment = Alignment.Center,
                modifier = Modifier
                    .pushedByIme(Values.Space.medium)
                    .padding(bottom = Values.Space.small)
            ) {
                Button(
                    enabled = !isLoading,
                    onClick = { login() },
                    modifier = Modifier.fillMaxWidth().alpha(if (isLoading) 0.3f else 1f)
                ) {
                    Text(
                        stringResource(R.string.login_view_login_button_title),
                        style = MaterialTheme.typography.h5,
                        textAlign = TextAlign.Center,
                    )
                }

                if (isLoading) CircularProgressIndicator(
                    strokeWidth = Values.Border.mediumLarge,
                    modifier = Modifier.size(30.dp)
                )
            }

            TextButton(onClick = { navigateToRegister() }) {
                Text(
                    stringResource(R.string.login_view_register_button_title),
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth()
                )
            }
        }
    }

}

private fun Modifier.pushedByIme(additionalSpace: Dp = 0.dp) = composed {
    var bottomPosition by remember { mutableStateOf(0) }
    val density = LocalDensity.current.density
    val spaceFromBottom = LocalView.current.height - bottomPosition
    val insets = LocalWindowInsets.current.ime

    val bottomOffset = (insets.bottom - spaceFromBottom + (additionalSpace.value * density))
        .coerceAtLeast(0f) / density

    onGloballyPositioned {
        if (bottomPosition == 0) // Get only first position
            bottomPosition = (it.positionInWindow().y + it.size.height).roundToInt()
    }.absoluteOffset(y = -bottomOffset.dp)
}