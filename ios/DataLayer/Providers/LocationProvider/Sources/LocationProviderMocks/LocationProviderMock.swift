//
//  Created by Petr Chmelar on 28.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import CoreLocation
import Foundation
import LocationProvider

public final class LocationProviderMock: LocationProvider {

    public init() {}

    // MARK: - isLocationEnabled

    public var isLocationEnabledCallsCount = 0
    public var isLocationEnabledCalled: Bool {
        return isLocationEnabledCallsCount > 0
    }
    public var isLocationEnabledReturnValue: Bool! // swiftlint:disable:this implicitly_unwrapped_optional
    public var isLocationEnabledClosure: (() -> Bool)?

    public func isLocationEnabled() -> Bool {
        isLocationEnabledCallsCount += 1
        if let isLocationEnabledClosure = isLocationEnabledClosure {
            return isLocationEnabledClosure()
        } else {
            return isLocationEnabledReturnValue
        }
    }

    // MARK: - getCurrentLocation

    public var getCurrentLocationWithAccuracyCallsCount = 0
    public var getCurrentLocationWithAccuracyCalled: Bool {
        return getCurrentLocationWithAccuracyCallsCount > 0
    }
    public var getCurrentLocationWithAccuracyReceivedAccuracy: CLLocationAccuracy?
    public var getCurrentLocationWithAccuracyReceivedInvocations: [CLLocationAccuracy] = []
    public var getCurrentLocationWithAccuracyReturnValue: AsyncStream<CLLocation>! // swiftlint:disable:this implicitly_unwrapped_optional
    public var getCurrentLocationWithAccuracyClosure: ((CLLocationAccuracy) -> AsyncStream<CLLocation>)?

    public func getCurrentLocation(withAccuracy accuracy: CLLocationAccuracy) -> AsyncStream<CLLocation> {
        getCurrentLocationWithAccuracyCallsCount += 1
        getCurrentLocationWithAccuracyReceivedAccuracy = accuracy
        getCurrentLocationWithAccuracyReceivedInvocations.append(accuracy)
        if let getCurrentLocationWithAccuracyClosure = getCurrentLocationWithAccuracyClosure {
            return getCurrentLocationWithAccuracyClosure(accuracy)
        } else {
            return getCurrentLocationWithAccuracyReturnValue
        }
    }

}
