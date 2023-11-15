package kmp.android.profile.ui

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.material.OutlinedTextField
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import kmp.android.shared.style.Values
import kmp.shared.domain.model.User

@Composable
fun UserEdit(user: User?, onUserChange: (User) -> Unit, modifier: Modifier = Modifier) {
    Box(modifier.fillMaxWidth()) {
        if (user == null) {
            Text(
                "No data",
                Modifier
                    .align(Alignment.Center)
                    .padding(Values.Space.large),
            )
        } else {
            Column(Modifier.padding(horizontal = Values.Space.medium)) {
                UserEditWithLabel(user.firstName, "First name") {
                    onUserChange(user.copy(firstName = it))
                }

                UserEditWithLabel(user.lastName, "Last name") {
                    onUserChange(user.copy(lastName = it))
                }

                UserEditWithLabel(user.bio, "Bio") {
                    onUserChange(user.copy(bio = it))
                }

                UserEditWithLabel(user.phone ?: "", "Phone number") {
                    onUserChange(user.copy(phone = it))
                }

                Spacer(Modifier.height(Values.Space.large))
            }
        }
    }
}

@Composable
private fun UserEditWithLabel(data: String, label: String, onChange: (String) -> Unit) {
    Column {
        Spacer(Modifier.height(Values.Space.medium))
        OutlinedTextField(
            value = data,
            onValueChange = onChange,
            label = { Text(label) },
            modifier = Modifier.fillMaxWidth(),
        )
    }
}
