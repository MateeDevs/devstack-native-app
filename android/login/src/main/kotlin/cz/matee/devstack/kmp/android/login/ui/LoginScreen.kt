package cz.matee.devstack.kmp.android.login.ui

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.text.KeyboardActions
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.material.*
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.compose.ui.composed
import androidx.compose.ui.layout.onGloballyPositioned
import androidx.compose.ui.layout.positionInWindow
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.platform.LocalView
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewmodel.compose.LocalViewModelStoreOwner
import androidx.navigation.NavHostController
import cz.matee.devstack.kmp.android.login.R
import cz.matee.devstack.kmp.android.login.vm.LoginViewModel
import cz.matee.devstack.kmp.android.shared.style.Values
import cz.matee.devstack.kmp.android.shared.ui.LocalSnackBarBehavior
import cz.matee.devstack.kmp.shared.infrastructure.remote.AuthService
import dev.chrisbanes.accompanist.insets.LocalWindowInsets
import dev.chrisbanes.accompanist.insets.navigationBarsPadding
import dev.chrisbanes.accompanist.insets.statusBarsPadding
import kotlinx.coroutines.launch
import org.koin.androidx.viewmodel.ViewModelOwner
import org.koin.androidx.viewmodel.koin.getViewModel
import org.koin.core.context.GlobalContext
import org.koin.core.parameter.ParametersDefinition
import org.koin.core.qualifier.Qualifier
import kotlin.math.roundToInt

@Composable
inline fun <reified T : ViewModel> getViewModel(
    qualifier: Qualifier? = null,
    noinline parameters: ParametersDefinition? = null,
): T {
    val owner = LocalViewModelStoreOwner.current.viewModelStore
    return remember {
        GlobalContext.get().getViewModel(
            qualifier,
            owner = { ViewModelOwner.from(owner) },
            parameters = parameters
        )
    }
}


@Composable
fun LoginScreen(navHostController: NavHostController) {
    val loginVm = getViewModel<LoginViewModel>()
    val scope = rememberCoroutineScope()
    val snackBar = LocalSnackBarBehavior.current

    var emailValue by remember { mutableStateOf(TextFieldValue()) }
    var passwordValue by remember { mutableStateOf(TextFieldValue()) }

    Column(
        modifier = Modifier
            .fillMaxWidth()
            .statusBarsPadding()
            .padding(horizontal = Values.Space.xlarge)
    ) {
        Text(
            text = stringResource(R.string.login_view_headline_title),
            style = MaterialTheme.typography.h4,
            color = MaterialTheme.colors.primary,
            modifier = Modifier.padding(top = Values.Space.large, bottom = Values.Space.xxlarge)
        )

        LoginTextField(
            value = emailValue,
            onValueChange = { emailValue = it },
            label = { Text(stringResource(R.string.login_view_email_field_hint)) },
            modifier = Modifier.fillMaxWidth().padding(bottom = Values.Space.large),
        )

        LoginTextField(
            value = passwordValue,
            onValueChange = { passwordValue = it },
            label = { Text(stringResource(R.string.login_view_password_field_hint)) },
        )

        Column(
            verticalArrangement = Arrangement.Bottom,
            modifier = Modifier
                .fillMaxSize()
                .navigationBarsPadding()
                .padding(bottom = Values.Space.medium)
        ) {

            Button(
                onClick = {
                    scope.launch {
                        loginVm.login(AuthService.LoginRequest("aaa", "bbb"))
                    }
                },
                modifier = Modifier
                    .pushedByIme(Values.Space.medium)
                    .padding(bottom = Values.Space.small)
            ) {
                Text(
                    stringResource(R.string.login_view_login_button_title),
                    style = MaterialTheme.typography.h5,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth()
                )
            }

            TextButton(onClick = {}) {
                Text(
                    stringResource(R.string.login_view_register_button_title),
                    textAlign = TextAlign.Center,
                    modifier = Modifier.fillMaxWidth()
                )
            }
        }
    }

}

@Composable
private fun LoginTextField(
    value: TextFieldValue,
    onValueChange: (TextFieldValue) -> Unit,
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    label: @Composable (() -> Unit)? = null,
    isErrorValue: Boolean = false,
    keyboardOptions: KeyboardOptions = KeyboardOptions.Default,
    keyboardActions: KeyboardActions = KeyboardActions(),
) {
    OutlinedTextField(
        value = value,
        onValueChange = onValueChange,
        modifier = modifier.fillMaxWidth(),
        enabled = enabled,
        label = label,
        isErrorValue = isErrorValue,
        keyboardOptions = keyboardOptions,
        keyboardActions = keyboardActions
    )
}

private fun Modifier.pushedByIme(additionalSpace: Dp = 0.dp) = composed {
    val density = LocalDensity.current.density
    var bottomPosition by remember { mutableStateOf(0) }
    val spaceFromBottom = LocalView.current.height - bottomPosition
    val insets = LocalWindowInsets.current.ime
    val bottomPadding = (insets.bottom - spaceFromBottom + (additionalSpace.value * density))
        .coerceAtLeast(0f) / density

    onGloballyPositioned {
        if (bottomPosition == 0) // Get only first position
            bottomPosition = (it.positionInWindow().y + it.size.height).roundToInt()
    }.padding(bottom = bottomPadding.dp)
}