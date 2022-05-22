//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import CoreLocation

public class SystemLocationProvider: NSObject {
    
    private let locationManager = CLLocationManager()
    private var locationHandler: ([CLLocation]) -> Void = { _ in }
    
    override public init() {
        super.init()
        locationManager.delegate = self
    }
}

extension SystemLocationProvider: LocationProvider {
    
    public func isLocationEnabled() -> Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    public func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> AsyncStream<CLLocation> {
        if !isLocationEnabled() {
            locationManager.requestWhenInUseAuthorization()
        }
        
        return AsyncStream(CLLocation.self) { continuation in
            locationHandler = { locations in
                guard let location = locations.first(where: { $0.horizontalAccuracy < accuracy }) else { return }
                continuation.yield(location)
            }
            locationManager.startUpdatingLocation()
        }
    }
}

extension SystemLocationProvider: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationHandler(locations)
    }
}
