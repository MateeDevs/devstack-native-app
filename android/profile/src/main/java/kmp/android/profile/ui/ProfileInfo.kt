package kmp.android.profile.ui

import android.location.Location
import androidx.annotation.StringRes
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.Button
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Surface
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.constraintlayout.compose.ConstraintLayout
import androidx.constraintlayout.compose.Dimension
import kmp.android.shared.R
import kmp.android.shared.style.Values
import kmp.android.shared.ui.UserProfileImage
import kmp.shared.domain.model.Book
import kmp.shared.domain.model.User
import kmp.shared.extension.fullName
import kotlinx.collections.immutable.ImmutableList

@Composable
fun ProfileContent(
    user: User,
    books: ImmutableList<Book>,
    locationValue: Location?,
    refreshBooks: () -> Unit,
    onLogOut: () -> Unit,
    modifier: Modifier = Modifier,
) {
    /**
     *  In the View system, ConstraintLayout was the recommended way to create large and complex
     *  layouts as the flat view hierarchy was better for performance. However, this is not a concern
     *  in Compose, which is able to efficiently handle deep layout hierarchies.
     *
     *  Constraint layout is the last resort - consider using combination of Row/Column/Box instead.
     *  It was used here for purpose of demonstration
     */

    ConstraintLayout(
        modifier
            .fillMaxSize()
            .verticalScroll(rememberScrollState()),
    ) {
        val (picture, name, email, phone, bio, location, booksList, logOutBtn) = createRefs()

        UserProfileImage(
            user,
            Modifier.constrainAs(picture) {
                top.linkTo(parent.top, Values.Space.medium)
                start.linkTo(parent.start, Values.Space.medium)
            },
        )

        Text(
            if (user.fullName.isBlank()) "Undefined name" else user.fullName,
            color = MaterialTheme.colors.onBackground.copy(if (user.bio.isBlank()) 0.5f else 1f),
            style = MaterialTheme.typography.h5,
            modifier = Modifier.constrainAs(name) {
                linkTo(picture.end, parent.end, Values.Space.medium, Values.Space.medium)
                top.linkTo(picture.top, Values.Space.small)
            },
        )

        Text(
            if (user.bio.isBlank()) "No bio" else user.bio,
            color = MaterialTheme.colors.onBackground.copy(if (user.bio.isBlank()) 0.5f else 1f),
            modifier = Modifier
                .constrainAs(bio) {
                    linkTo(picture.end, parent.end, Values.Space.medium, Values.Space.medium)
                    top.linkTo(name.bottom, Values.Space.medium)
                    width = Dimension.fillToConstraints
                }
                .border(Values.Border.medium, MaterialTheme.colors.surface, CircleShape)
                .padding(Values.Space.medium),
        )

        TextWithLabel(
            R.string.profile_view_label_email,
            user.email,
            Modifier.constrainAs(email) {
                start.linkTo(parent.start, Values.Space.medium)
                top.linkTo(bio.bottom, Values.Space.large)
            },
        )

        TextWithLabel(
            R.string.profile_view_label_phone,
            user.phone ?: "",
            Modifier.constrainAs(phone) {
                start.linkTo(parent.start, Values.Space.medium)
                top.linkTo(email.bottom, Values.Space.large)
            },
        )

        Surface(
            Modifier
                .constrainAs(location) {
                    linkTo(parent.start, parent.end)
                    top.linkTo(phone.bottom)
                    width = Dimension.fillToConstraints
                }
                .padding(Values.Space.large),
            shape = RoundedCornerShape(Values.Radius.large),
        ) {
            Box {
                Text(
                    if (locationValue != null) {
                        "${locationValue.latitude}, ${locationValue.longitude}"
                    } else {
                        "Location permission not granted"
                    },
                    Modifier
                        .padding(Values.Space.medium)
                        .align(Alignment.Center),
                )
            }
        }

        BookList(
            books = books,
            refreshBooks = refreshBooks,
            Modifier.constrainAs(booksList) {
                linkTo(parent.start, location.bottom, parent.end, logOutBtn.top)
                width = Dimension.fillToConstraints
                height = Dimension.fillToConstraints
            },
        )

        Button(
            onLogOut,
            shape = MaterialTheme.shapes.medium,
            modifier = Modifier
                .padding(Values.Space.medium)
                .constrainAs(logOutBtn) {
                    linkTo(start = parent.start, end = parent.end)
                    bottom.linkTo(parent.bottom)
                    width = Dimension.fillToConstraints
                },
        ) {
            Text(
                stringResource(R.string.profile_view_logout_button),
                Modifier.padding(vertical = Values.Space.xsmall),
            )
        }
    }
}

@Composable
private fun TextWithLabel(@StringRes label: Int, text: String, modifier: Modifier = Modifier) {
    Column(modifier) {
        Text("${stringResource(label)}:", fontWeight = FontWeight.Bold)
        Text(text)
    }
}
