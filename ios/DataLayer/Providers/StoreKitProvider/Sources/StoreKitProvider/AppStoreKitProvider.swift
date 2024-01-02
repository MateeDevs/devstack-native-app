//
//  Created by Tereza Chodurová on 02.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import StoreKit

public final class AppStoreKitProvider: StoreKitProvider {
    
    public init() {}
    
    public func requestReview() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
