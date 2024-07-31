package kmp.shared.sample.domain.usecase

import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResultNoParams
import kmp.shared.sample.domain.model.SampleText
import kmp.shared.sample.domain.repository.SampleRepository

interface GetSampleTextUseCase : UseCaseResultNoParams<SampleText>

internal class GetSampleTextUseCaseImpl(
    private val repository: SampleRepository,
) : GetSampleTextUseCase {

    override suspend fun invoke(): Result<SampleText> =
        repository.getSampleText()
}
