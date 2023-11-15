package kmp.android.shared.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import kmp.android.shared.style.Values
import kmp.shared.domain.model.User

@Composable
fun UserProfileImage(
    user: User,
    modifier: Modifier = Modifier,
    color: Color = MaterialTheme.colors.primary,
) {
    Box(
        modifier
            .clip(CircleShape)
            .background(color)
            .padding(Values.Space.medium),
    ) {
        if (user.firstName.isNotBlank() && user.lastName.isNotBlank()) {
            Text(
                "${user.firstName[0]}${user.lastName[0]}",
                style = MaterialTheme.typography.h3,
            )
        } else {
            Text( // Render something so Box ha size
                "AA",
                style = MaterialTheme.typography.h3,
                modifier = Modifier.alpha(0f),
            )
        }
    }
}
