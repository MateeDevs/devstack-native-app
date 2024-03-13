//
//  Created by David Kadlček on 11.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import SharedDomain
import StoreKitProvider

public struct StoreKitRepositoryImpl: StoreKitRepository {
    
    private let storeKitProvider: StoreKitProvider
    
    public init(
        storeKitProvider: StoreKitProvider
    ) {
        self.storeKitProvider = storeKitProvider
    }
    
    public func requestFeedback() throws {
        try storeKitProvider.requestReview()
    }
}
