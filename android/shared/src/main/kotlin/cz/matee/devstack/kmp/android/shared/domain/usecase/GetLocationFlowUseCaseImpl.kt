package cz.matee.devstack.kmp.android.shared.domain.usecase

import android.location.Location
import cz.matee.devstack.kmp.android.shared.domain.controller.LocationController
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParamsImpl
import kotlinx.coroutines.flow.Flow

interface GetLocationFlowUseCase : UseCaseNoParams<Flow<Location>>

class GetLocationFlowUseCaseImpl(
    private val locationController: LocationController
) : UseCaseNoParamsImpl<Flow<Location>>(), GetLocationFlowUseCase {
    override suspend fun doWork(params: Unit): Flow<Location> = locationController.locationFlow
}