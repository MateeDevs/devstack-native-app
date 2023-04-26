package cz.matee.devstack.kmp.shared.domain.usecase.video

import cz.matee.devstack.kmp.shared.base.usecase.UseCaseFlow
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressOptions
import cz.matee.devstack.kmp.shared.domain.model.VideoCompressResult
import cz.matee.devstack.kmp.shared.domain.repository.VideoRepository

interface CompressVideoUseCase :
    UseCaseFlow<CompressVideoUseCase.Params, VideoCompressResult> {

    data class Params(
        val inputPath: String,
        val outputPath: String,
        val options: VideoCompressOptions,
    )
}

internal class CompressVideoUseCaseImpl(
    private val videoRepository: VideoRepository,
) : CompressVideoUseCase {
    override suspend fun invoke(params: CompressVideoUseCase.Params) =
        videoRepository.compress(
            params.inputPath,
            params.outputPath,
            params.options,
        )
}