package kmp.shared.sample.domain.repository

import kmp.shared.base.Result
import kmp.shared.sample.domain.model.SampleText

internal interface SampleRepository {
    suspend fun getSampleText(): Result<SampleText>
}
