package kmp.android.shared.di

import android.content.Context
import com.google.android.gms.location.LocationServices
import kmp.android.shared.device.LocationControllerImpl
import kmp.android.shared.domain.controller.LocationController
import kmp.android.shared.domain.usecase.GetLocationFlowUseCase
import kmp.android.shared.domain.usecase.GetLocationFlowUseCaseImpl
import org.koin.dsl.module

val androidSharedModule = module {
    single<LocationController> {
        LocationControllerImpl(
            context = get(),
            locationProvider = LocationServices.getFusedLocationProviderClient(get<Context>()),
        )
    }

    factory<GetLocationFlowUseCase> { GetLocationFlowUseCaseImpl(get()) }
}
