//
//  Created by Petr Chmelar on 06.10.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import AnalyticsProvider
import Factory
import KeychainProvider
import NetworkProvider
import UIKit
import UserDefaultsProvider
import Utilities

public extension Container {
    var keychainProvider: Factory<KeychainProvider> { self { SystemKeychainProvider() } }
    var analyticsProvider: Factory<AnalyticsProvider> { self { FirebaseAnalyticsProvider() } }
    var networkProvider: Factory<NetworkProvider> { self { SystemNetworkProvider(
        readAuthToken: { try self.keychainProvider().read(.authToken) },
        delegate: UIApplication.shared.delegate as? NetworkProviderDelegate
    )}}
    var userDefaultsProvider: Factory<UserDefaultsProvider> { self { SystemUserDefaultsProvider() } }
}
