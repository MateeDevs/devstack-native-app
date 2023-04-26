package cz.matee.devstack.kmp.shared.domain.model

import kotlin.time.Duration
import kotlin.time.Duration.Companion.seconds

data class VideoCompressOptions(
    val bitrate: Long? = null,
    val frameRate: Int? = null,
    val trim: Duration? = null,
    val maximumSize: Pair<Int, Int>? = null,
) {
    companion object
}

fun VideoCompressOptions.Companion.default() = VideoCompressOptions(
    bitrate = 7000000, // 7000 kB/s
    frameRate = 30,
    trim = 30.seconds,
    maximumSize = Pair(1280, 720),
)
