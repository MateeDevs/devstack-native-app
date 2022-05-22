//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol UserRepository: AutoMockable {
    func create(_ data: RegistrationData) async throws -> User
    func read(_ sourceType: SourceType, id: String) async throws -> User
    func read(_ sourceType: SourceType, page: Int, sortBy: String?) async throws -> [User]
    func update(_ sourceType: SourceType, user: User) async throws -> User
}
