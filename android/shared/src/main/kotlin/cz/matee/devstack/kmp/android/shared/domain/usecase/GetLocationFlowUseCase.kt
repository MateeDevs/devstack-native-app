package cz.matee.devstack.kmp.android.shared.domain.usecase

import android.location.Location
import cz.matee.devstack.kmp.android.shared.domain.controller.LocationController
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import kotlinx.coroutines.flow.Flow

class GetLocationFlowUseCase(
    private val locationController: LocationController
) : UseCaseNoParams<Flow<Location>>() {
    override suspend fun doWork(params: Unit): Flow<Location> = locationController.locationFlow
}