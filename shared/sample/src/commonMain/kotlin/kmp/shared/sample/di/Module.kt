package kmp.shared.sample.di

import kmp.shared.sample.data.repository.SampleRepositoryImpl
import kmp.shared.sample.data.source.SampleSource
import kmp.shared.sample.domain.repository.SampleRepository
import kmp.shared.sample.domain.usecase.GetSampleTextUseCase
import kmp.shared.sample.domain.usecase.GetSampleTextUseCaseImpl
import kmp.shared.sample.infrastructure.remote.SampleService
import kmp.shared.sample.infrastructure.source.SampleSourceImpl
import org.koin.core.module.dsl.factoryOf
import org.koin.core.module.dsl.singleOf
import org.koin.dsl.bind
import org.koin.dsl.module

val sampleModule = module {
    // Use cases
    factoryOf(::GetSampleTextUseCaseImpl) bind GetSampleTextUseCase::class

    // Repositories
    singleOf(::SampleRepositoryImpl) bind SampleRepository::class

    // Sources
    singleOf(::SampleSourceImpl) bind SampleSource::class

    // Remote services
    singleOf(::SampleService)
}
