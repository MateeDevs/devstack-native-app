//
//  Created by Tomáš Batěk on 27.04.2023
//  Copyright © 2023 Matee. All rights reserved.
//

import Foundation
import DevstackKmpShared

public struct KMMError: Error {
    
    private let _errorResult: ErrorResult?
    private let _throwable: KotlinThrowable?
    
    init(from errorResult: ErrorResult) {
        self._errorResult = errorResult
        self._throwable = nil
    }
    
    init(from throwable: KotlinThrowable) {
        self._throwable = throwable
        self._errorResult = nil
    }
    
    public var errorResult: ErrorResult? { _errorResult }
    
    public var throwable: KotlinThrowable? { _throwable }
}
