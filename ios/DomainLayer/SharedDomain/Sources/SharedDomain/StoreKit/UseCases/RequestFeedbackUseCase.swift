//
//  Created by David Kadlček on 11.01.2024
//  Copyright © 2024 Matee. All rights reserved.
//

import Foundation
import Spyable
import Utilities

@Spyable
public protocol RequestFeedbackUseCase {
    func execute() throws
}

public struct RequestFeedbackUseCaseImpl: RequestFeedbackUseCase {
    
    private let storeKitRepository: StoreKitRepository
    
    public init(storeKitRepository: StoreKitRepository) {
        self.storeKitRepository = storeKitRepository
    }
    
    public func execute() throws {
        if Environment.flavor == Utilities.EnvironmentFlavor.debug {
            guard CommandLine.arguments.contains("-ShouldShowFeedback") else { return }
            
            try storeKitRepository.requestFeedback()
        } else {
            try storeKitRepository.requestFeedback()
        }
    }
}
