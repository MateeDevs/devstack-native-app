//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import Utilities

// sourcery: AutoMockable
public protocol UserRepository {
    func read(_ sourceType: SourceType, id: String) async throws -> User
    func read(_ sourceType: SourceType, page: Int, limit: Int, sortBy: String?) async throws -> Pages<User>
    func update(_ sourceType: SourceType, user: User) async throws -> User
}
