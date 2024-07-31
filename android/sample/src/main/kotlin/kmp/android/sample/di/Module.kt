package kmp.android.sample.di

import kmp.android.sample.vm.SampleViewModel
import org.koin.androidx.viewmodel.dsl.viewModelOf
import org.koin.dsl.module

val androidSampleModule = module {
    viewModelOf(::SampleViewModel)
}
