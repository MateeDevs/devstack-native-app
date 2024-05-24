package kmp.shared.domain.usecase.video

import kmp.shared.domain.model.VideoCompressLibrary
import kmp.shared.domain.model.VideoCompressOptions
import kmp.shared.domain.repository.VideoRepository
import kmp.shared.base.usecase.UseCaseFlow
import kmp.shared.domain.model.MediaUrlPath
import kmp.shared.domain.model.VideoCompressResult

interface CompressVideoUseCase :
    UseCaseFlow<CompressVideoUseCase.Params, VideoCompressResult> {

    data class Params(
        val inputPath: MediaUrlPath,
        val outputPath: MediaUrlPath,
        val options: VideoCompressOptions,
        val library: VideoCompressLibrary,
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
            params.library,
        )
}
