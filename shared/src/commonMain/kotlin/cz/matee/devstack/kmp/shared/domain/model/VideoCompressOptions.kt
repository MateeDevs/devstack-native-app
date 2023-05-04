package cz.matee.devstack.kmp.shared.domain.model

import kotlin.time.Duration
import kotlin.time.Duration.Companion.seconds

data class VideoCompressOptions(
    val bitrate: Long? = null,
    val frameRate: Int? = null,
    val trim: Duration? = null,
    val maximumSize: Pair<Int, Int>? = null,
    val audioBitrate: Long? = null,
    val audioSampleRate: Int? = null,
) {
    override fun toString(): String = buildString {
        bitrate?.let { append("-b:$it") }
        frameRate?.let { append("-f:$it") }
        trim?.let { append("-t:$it") }
        maximumSize?.let { append("-m:$it") }
    }

    companion object
}

fun VideoCompressOptions.Companion.default() = VideoCompressOptions(
    bitrate = 3_500_000, // 3500 kB/s
    frameRate = 30,
    trim = 20.seconds,
    maximumSize = Pair(1920, 1080),
    audioBitrate = 128_000,
    audioSampleRate = 32_000,
)
