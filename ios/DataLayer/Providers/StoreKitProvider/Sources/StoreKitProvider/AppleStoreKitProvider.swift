//
//  Created by David Kadlček on 11.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import StoreKit

public final class AppleStoreKitProvider: StoreKitProvider {
    public init() {}
    
    public func requestReview() throws {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            throw StoreKitProviderError.invalidWindow
        }
    }
}
