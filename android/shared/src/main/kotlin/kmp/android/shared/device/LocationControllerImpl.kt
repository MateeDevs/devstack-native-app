package kmp.android.shared.device

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.location.Location
import android.os.Looper
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationCallback
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationResult
import com.google.android.gms.location.Priority
import kmp.android.shared.device.LocationControllerImpl.LocationUpdateCallback
import kmp.android.shared.domain.controller.LocationController
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.flow.filterNotNull

private const val UPDATE_INTERVAL = 1000L

internal class LocationControllerImpl(
    private val context: Context,
    private val locationProvider: FusedLocationProviderClient,
) : LocationController {
    fun interface LocationUpdateCallback {
        fun onLocationUpdate(location: Location)
    }

    private var listening: Boolean = false
    private val locationListeners: MutableList<LocationUpdateCallback> = mutableListOf()
    private var locationCallback: LocationCallback? = null

    override var lastLocation: Location? = null
        private set

    @OptIn(ExperimentalCoroutinesApi::class)
    override val locationFlow = callbackFlow {
        if (locationListeners.isEmpty() || (locationListeners.isNotEmpty() && !listening)) {
            startListening()
        }
        this.trySend(lastLocation).isSuccess

        val callback = LocationUpdateCallback { location -> this.trySend(location).isSuccess }
        accessListeners { add(callback) }

        awaitClose {
            accessListeners { remove(callback) }
            if (locationListeners.isEmpty()) stopListening()
        }
    }.filterNotNull()

    @SuppressLint("MissingPermission")
    private fun startListening() {
        if (permissionGranted) {
            stopListening()
            listening = true

            // Fetch last location as fast as possible
            locationProvider.lastLocation.addOnCompleteListener { task ->
                lastLocation = task.result
                lastLocation?.let { location ->
                    locationListeners.forEach { it.onLocationUpdate(location) }
                }
            }

            val request = LocationRequest.Builder(UPDATE_INTERVAL)
                .setPriority(Priority.PRIORITY_HIGH_ACCURACY).build()

            val callback = object : LocationCallback() {
                override fun onLocationResult(result: LocationResult) {
                    lastLocation = result.lastLocation
                    lastLocation?.let { location ->
                        locationListeners.forEach { it.onLocationUpdate(location) }
                    }
                }
            }.also { locationCallback = it }

            locationProvider.requestLocationUpdates(request, callback, Looper.getMainLooper())
        }
    }

    private fun stopListening() {
        locationCallback?.let(locationProvider::removeLocationUpdates)
        listening = false
    }

    private val permissionGranted
        get() = ActivityCompat.checkSelfPermission(
            context,
            Manifest.permission.ACCESS_FINE_LOCATION,
        ) == PackageManager.PERMISSION_GRANTED

    /**
     * Helper function to prevent ConcurrentModification by synchronizing access to listeners
     */
    @Synchronized
    private fun accessListeners(block: MutableList<LocationUpdateCallback>.() -> Unit) =
        locationListeners.block()
}
