package kmp.android.shared.domain.usecase

import android.location.Location
import kmp.android.shared.domain.controller.LocationController
import kmp.shared.base.Result
import kmp.shared.base.usecase.UseCaseResultNoParams
import kotlinx.coroutines.flow.Flow

interface GetLocationFlowUseCase : UseCaseResultNoParams<Flow<Location>>

internal class GetLocationFlowUseCaseImpl(
    private val locationController: LocationController,
) : GetLocationFlowUseCase {
    override suspend fun invoke(): Result<Flow<Location>> =
        Result.Success(locationController.locationFlow)
}
