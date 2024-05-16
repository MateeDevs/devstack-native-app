package cz.matee.devstack.kmp.android.videos.ui

import android.content.res.Configuration
import android.view.ViewGroup
import android.widget.FrameLayout
import androidx.annotation.OptIn
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.CircularProgressIndicator
import androidx.compose.material.MaterialTheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.DisposableEffect
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.toArgb
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import androidx.compose.ui.viewinterop.AndroidView
import androidx.core.net.toUri
import androidx.media3.common.MediaItem
import androidx.media3.common.PlaybackException
import androidx.media3.common.Player
import androidx.media3.common.Player.REPEAT_MODE_ALL
import androidx.media3.common.util.UnstableApi
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.ui.AspectRatioFrameLayout.RESIZE_MODE_FIT
import androidx.media3.ui.AspectRatioFrameLayout.RESIZE_MODE_ZOOM
import androidx.media3.ui.PlayerView

@OptIn(UnstableApi::class)
@Composable
fun VideoPlayer(
    uri: String?,
    modifier: Modifier = Modifier,
    muted: Boolean = false,
) {
    val context = LocalContext.current
    val exoPlayer = remember(context) {
        ExoPlayer.Builder(context).build().apply {
            repeatMode = REPEAT_MODE_ALL
        }
    }
    var playerView: PlayerView = remember {
        PlayerView(context)
    }
    val isVideoBuffering = remember {
        mutableStateOf(false)
    }
    val backGroundColor = MaterialTheme.colors.background
    val configuration = LocalConfiguration.current
    var autoPaused = false

    DisposableEffect(Unit) {
        onDispose { exoPlayer.pause() }
    }

//    ComposableLifecycle { _, event ->
//        when (event) {
//            Lifecycle.Event.ON_PAUSE -> {
//                exoPlayer.pause()
//                autoPaused = true
//            }
//
//            Lifecycle.Event.ON_RESUME -> {
//                if (autoPaused) {
//                    exoPlayer.play()
//                    autoPaused = false
//                }
//            }
//
//            else -> {}
//        }
//    }

    LaunchedEffect(uri) {
        val video = uri
        if (video != null) {
            val mediaItem = MediaItem.fromUri("file:///" + video)
            exoPlayer.clearMediaItems()
            exoPlayer.setMediaItem(mediaItem)
            exoPlayer.prepare()
            exoPlayer.volume = if (muted) 0f else 1f
            exoPlayer.play()
        }
    }

    Box(
        modifier = modifier,
    ) {
        AndroidView(
            modifier = Modifier.fillMaxSize(),
            factory = {
                playerView.apply {
                    setShutterBackgroundColor(backGroundColor.toArgb())
                    keepScreenOn = true
                    player = exoPlayer
                    playerView = this
                    useController = false
                    layoutParams = FrameLayout.LayoutParams(
                        ViewGroup.LayoutParams.MATCH_PARENT,
                        ViewGroup.LayoutParams.MATCH_PARENT,
                    )
                    resizeMode = RESIZE_MODE_FIT
//                        if (configuration.orientation == Configuration.ORIENTATION_LANDSCAPE) {
//                            RESIZE_MODE_FIT
//                        } else {
//                            RESIZE_MODE_ZOOM
//                        }

                    exoPlayer.addListener(
                        object : Player.Listener {
                            override fun onPlaybackStateChanged(state: Int) {
                                when (state) {
                                    Player.STATE_BUFFERING -> {
                                        isVideoBuffering.value = true
                                    }

                                    Player.STATE_READY -> {
                                        isVideoBuffering.value = false
                                    }

                                    else -> {
                                        println("Playback state: $state")
                                    }
                                }
                            }

                            override fun onPlayerError(error: PlaybackException) {
                                super.onPlayerError(error)
                                println("Playback error: $error")
                            }
                        },
                    )
                }
            },
            update = {
                it.setBackgroundColor(Color.Black.toArgb())
            },
        )

        if (
            isVideoBuffering.value &&
            configuration.orientation
            == Configuration.ORIENTATION_LANDSCAPE
        ) {
            CircularProgressIndicator(
                modifier = Modifier
                    .align(Alignment.Center)
                    .background(Color.Transparent, shape = CircleShape)
                    .size(40.dp),
            )
        }
    }
}