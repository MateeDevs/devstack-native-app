package kmp.shared.sample.infrastructure.source

import kmp.shared.base.Result
import kmp.shared.sample.data.source.SampleSource
import kmp.shared.sample.infrastructure.model.SampleTextDto
import kmp.shared.sample.infrastructure.remote.SampleService

internal class SampleSourceImpl(
    private val service: SampleService,
) : SampleSource {

    override suspend fun getSampleText(): Result<SampleTextDto> =
        service.getSampleText(Unit)
}
