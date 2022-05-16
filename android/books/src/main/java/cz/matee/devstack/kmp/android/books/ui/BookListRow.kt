package cz.matee.devstack.kmp.android.books.ui

import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.CornerSize
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Card
import androidx.compose.material.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import cz.matee.devstack.kmp.android.books.R

@Composable
fun BookListRow(name: String, author: String) {
    Card(
        modifier = Modifier
            .padding(
                vertical = 6.dp
            )
            .fillMaxWidth(),
        shape = RoundedCornerShape(
            corner = CornerSize(16.dp)
        ),
        backgroundColor = Color.White
    ) {
        ImageAndInfo(name, author)
    }
}

@Composable
private fun ImageAndInfo(name: String, author: String) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .border(
                1.dp,
                color = Color.LightGray
            )
            .padding(
                vertical = 20.dp
            ),
        verticalAlignment = Alignment.CenterVertically
    ) {
        BookImage()
        BookInfo(name, author)
    }
}

@Composable
private fun BookImage() {
    Image(
        painter = painterResource(id = R.drawable.sn_mka_obrazovky_2022_05_11_091858),
        contentDescription = "book",
        modifier = Modifier
            .padding(
                start = 30.dp,
                end = 30.dp
            )
            .size(80.dp)
            .shadow(
                elevation = 20.dp,
                shape = CircleShape
            )
            .clip(CircleShape),
        contentScale = ContentScale.Crop,
    )
}

@Composable
private fun BookInfo(name: String, author: String) {
    Column() {
        Text(
            text = name,
            fontSize = 20.sp
        )
        Text(
            text = author,
            fontSize = 15.sp,
            color = Color.Gray
        )
    }
}

