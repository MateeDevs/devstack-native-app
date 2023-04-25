package cz.matee.devstack.kmp.android.shared.domain.controller

import android.location.Location
import kotlinx.coroutines.flow.Flow

interface LocationController {
    val lastLocation: Location?
    val locationFlow: Flow<Location>
}
