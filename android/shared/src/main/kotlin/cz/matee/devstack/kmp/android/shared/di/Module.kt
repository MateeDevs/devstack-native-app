package cz.matee.devstack.kmp.android.shared.di

import android.content.Context
import com.google.android.gms.location.LocationServices
import cz.matee.devstack.kmp.android.shared.base.error.ErrorMessageProviderImpl
import cz.matee.devstack.kmp.android.shared.device.LocationControllerImpl
import cz.matee.devstack.kmp.android.shared.domain.controller.LocationController
import cz.matee.devstack.kmp.android.shared.domain.usecase.GetLocationFlowUseCase
import cz.matee.devstack.kmp.android.shared.domain.usecase.GetLocationFlowUseCaseImpl
import cz.matee.devstack.kmp.shared.base.error.ErrorMessageProvider
import org.koin.dsl.module

val androidSharedModule = module {
    single<ErrorMessageProvider> { ErrorMessageProviderImpl(get()) }
    single<LocationController> {
        LocationControllerImpl(
            context = get(),
            locationProvider = LocationServices.getFusedLocationProviderClient(get<Context>())
        )
    }

    factory<GetLocationFlowUseCase> { GetLocationFlowUseCaseImpl(get()) }
}