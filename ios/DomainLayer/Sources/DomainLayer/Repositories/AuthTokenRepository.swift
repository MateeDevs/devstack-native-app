//
//  Created by Petr Chmelar on 05.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import RxSwift

public protocol HasAuthTokenRepository {
    var authTokenRepository: AuthTokenRepository { get }
}

public protocol AuthTokenRepository: AutoMockable {
    func create(_ data: LoginData) -> Observable<AuthToken>
    func read() -> AuthToken?
    func delete()
}
