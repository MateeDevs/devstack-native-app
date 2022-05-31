//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

public protocol AuthRepository: AutoMockable {
    func login(_ data: LoginData) async throws
    func registration(_ data: RegistrationData) async throws
    func readProfileId() throws -> String
    func logout() throws
}
