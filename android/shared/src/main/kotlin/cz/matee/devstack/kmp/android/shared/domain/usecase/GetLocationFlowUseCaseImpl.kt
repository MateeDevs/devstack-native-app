package cz.matee.devstack.kmp.android.shared.domain.usecase

import android.location.Location
import cz.matee.devstack.kmp.android.shared.domain.controller.LocationController
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseNoParams
import kotlinx.coroutines.flow.Flow

interface GetLocationFlowUseCase : UseCaseNoParams<Flow<Location>>

class GetLocationFlowUseCaseImpl(
    private val locationController: LocationController
) :  GetLocationFlowUseCase {
    override suspend fun invoke(): Flow<Location> = locationController.locationFlow
}