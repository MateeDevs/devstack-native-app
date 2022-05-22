//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol AuthTokenRepository: AutoMockable {
    func create(_ data: LoginData) async throws -> AuthToken
    func read() throws -> AuthToken
    func delete() throws
}
