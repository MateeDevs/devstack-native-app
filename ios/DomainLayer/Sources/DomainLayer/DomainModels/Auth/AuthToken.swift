//
//  Created by Petr Chmelar on 22.02.2021.
//  Copyright © 2021 Matee. All rights reserved.
//

public struct AuthToken: Equatable {
    public let userId: String
    public let token: String
    
    public init(
        userId: String,
        token: String
    ) {
        self.userId = userId
        self.token = token
    }
}
