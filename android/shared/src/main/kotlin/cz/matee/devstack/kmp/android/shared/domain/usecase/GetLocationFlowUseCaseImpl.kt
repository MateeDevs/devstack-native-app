package cz.matee.devstack.kmp.android.shared.domain.usecase

import android.location.Location
import cz.matee.devstack.kmp.android.shared.domain.controller.LocationController
import cz.matee.devstack.kmp.shared.base.Result
import cz.matee.devstack.kmp.shared.base.usecase.UseCaseResultNoParams
import cz.matee.devstack.kmp.shared.base.util.helpers.Success
import cz.matee.devstack.kmp.shared.base.util.helpers.resultsTo
import kotlinx.coroutines.flow.Flow

interface GetLocationFlowUseCase : UseCaseResultNoParams<Flow<Location>>

class GetLocationFlowUseCaseImpl(
    private val locationController: LocationController,
) : GetLocationFlowUseCase {
    override suspend fun invoke(): Result<Flow<Location>> =
        locationController.locationFlow.resultsTo(Success)
}
