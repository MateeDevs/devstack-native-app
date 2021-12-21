//
//  Created by Viktor Kaderabek on 10/08/2018.
//  Copyright © 2018 Matee. All rights reserved.
//

import CoreLocation
import DomainLayer
import RxSwift

public class LocationRepositoryImpl: LocationRepository {

    public typealias Dependencies = HasNoProvider
    
    private let locationManager = CLLocationManager()
    
    public init(dependencies: Dependencies) {}
    
    public func isLocationEnabled() -> Bool {
        guard CLLocationManager.locationServicesEnabled() else { return false }
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    public func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> Observable<CLLocation> {
        locationManager.rx.didUpdateLocations
            .map { locations in locations[0] }
            .filter { location in location.horizontalAccuracy < accuracy }
            .do(
                onCompleted: { [weak self] in
                    self?.locationManager.stopUpdatingLocation()
                },
                onSubscribed: { [weak self] in
                    guard let self = self else { return }
                    if !self.isLocationEnabled() {
                        self.locationManager.requestWhenInUseAuthorization()
                    }
                    self.locationManager.startUpdatingLocation()
                },
                onDispose: { [weak self] in
                    self?.locationManager.stopUpdatingLocation()
                }
            )
    }
}
