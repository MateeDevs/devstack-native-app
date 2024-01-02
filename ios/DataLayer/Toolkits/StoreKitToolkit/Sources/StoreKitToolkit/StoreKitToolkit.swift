//
//  Created by Tereza Chodurová on 02.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import SharedDomain
import StoreKitProvider

public class StoreKitRepositoryImpl: StoreKitRepository {
    private let storeKitProvider: StoreKitProvider
    
    public init(
        storeKitProvider: StoreKitProvider
    ) {
        self.storeKitProvider = storeKitProvider
    }
    
    public func requestReview() {
        storeKitProvider.requestReview()
    }
}
