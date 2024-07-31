package kmp.shared.sample.infrastructure.model

import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class SampleTextDto(
    @SerialName("value")
    val value: String,
)
