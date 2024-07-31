package kmp.shared.sample.data.repository

import kmp.shared.base.Result
import kmp.shared.base.util.extension.map
import kmp.shared.sample.data.source.SampleSource
import kmp.shared.sample.domain.model.SampleText
import kmp.shared.sample.domain.repository.SampleRepository
import kmp.shared.sample.extension.toDomain
import kmp.shared.sample.infrastructure.model.SampleTextDto

internal class SampleRepositoryImpl(
    private val source: SampleSource,
) : SampleRepository {

    override suspend fun getSampleText(): Result<SampleText> =
        source.getSampleText().map(SampleTextDto::toDomain)
}
