package kmp.shared.sample.extension

import kmp.shared.sample.domain.model.SampleText
import kmp.shared.sample.infrastructure.model.SampleTextDto

internal fun SampleTextDto.toDomain(): SampleText =
    SampleText(value = value)
