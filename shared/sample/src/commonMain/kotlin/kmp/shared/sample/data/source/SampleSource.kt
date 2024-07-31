package kmp.shared.sample.data.source

import kmp.shared.base.Result
import kmp.shared.sample.infrastructure.model.SampleTextDto

internal interface SampleSource {
    suspend fun getSampleText(): Result<SampleTextDto>
}
