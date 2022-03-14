//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol AuthTokenRepository: AutoMockable {
    func create(_ data: LoginData) async throws -> AuthToken
    func createRx(_ data: LoginData) -> Observable<AuthToken>
    func read() -> AuthToken?
    func delete()
}
