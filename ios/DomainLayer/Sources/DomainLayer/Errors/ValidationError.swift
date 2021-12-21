//
//  Created by Petr Chmelar on 18/03/2019.
//  Copyright © 2019 Matee. All rights reserved.
//

import Foundation

public struct ValidationError: LocalizedError {
    
    private let message: String
    
    public init(_ message: String) {
        self.message = message
    }
    
    public var errorDescription: String? {
        message
    }
}
