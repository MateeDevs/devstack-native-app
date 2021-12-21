//
//  Created by Petr Chmelar on 04.03.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer
import RxSwift

public protocol HasRemoteConfigProvider {
    var remoteConfigProvider: RemoteConfigProvider { get }
}

public protocol RemoteConfigProvider: AutoMockable {
    /// Try to retrieve a value for the given key
    func get(_ key: RemoteConfigCoding) -> Observable<Bool>
}
