package cz.matee.devstack.kmp.android.books.ui

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import com.google.accompanist.placeholder.PlaceholderHighlight
import com.google.accompanist.placeholder.placeholder
import com.google.accompanist.placeholder.shimmer

@Composable
fun ShimmerRow() {
    Row(
        modifier = Modifier
            .padding(top = 8.dp, end = 3.dp, bottom = 8.dp, start = 3.dp)
            .fillMaxWidth()
            .height(120.dp)
            .background(Color.White, RoundedCornerShape(16.dp)),
        verticalAlignment = Alignment.CenterVertically
    ) {
        ShimmerImage()
        Column() {
            ShimmerText(width = 200, height = 20)
            ShimmerText(width = 150, height = 15)
        }
    }
}

@Composable
private fun ShimmerImage() {
    Box(
        modifier = Modifier
            .padding(
                top = 8.dp,
                bottom = 8.dp,
                start = 30.dp,
                end = 8.dp)
            .width(80.dp)
            .height(80.dp)
            .clip(CircleShape)
            .placeholder(
                visible = true,
                highlight = PlaceholderHighlight.shimmer(highlightColor = Color.White),
                color = Color.LightGray
            )
    )
}

@Composable
private fun ShimmerText(width: Int, height: Int) {
    Box(
        modifier = Modifier
            .padding(top = 9.dp, end = 8.dp, bottom = 8.dp, start = 30.dp)
            .width(width.dp)
            .height(height.dp)
            .clip(RoundedCornerShape(18.dp))
            .placeholder(
                visible = true,
                highlight = PlaceholderHighlight.shimmer(highlightColor = Color.White),
                color = Color.LightGray
            )
    )
}

@Preview
@Composable
fun ShowShimmer() {
    ShimmerRow()
}