//
//  Created by Petr Chmelar on 20.05.2022
//  Copyright © 2022 Matee. All rights reserved.
//

import Spyable

@Spyable
public protocol IsUserLoggedUseCase {
    func execute() -> Bool
}

public struct IsUserLoggedUseCaseImpl: IsUserLoggedUseCase {
    
    private let getProfileIdUseCase: GetProfileIdUseCase
    
    public init(getProfileIdUseCase: GetProfileIdUseCase) {
        self.getProfileIdUseCase = getProfileIdUseCase
    }
    
    public func execute() -> Bool {
        do {
            _ = try getProfileIdUseCase.execute()
            return true
        } catch { return false }
    }
}
