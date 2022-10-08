//
//  Created by Petr Chmelar on 01.06.2022
//  Copyright © 2022 Matee. All rights reserved.
//

// sourcery: AutoMockable
public protocol RocketLaunchRepository {
    func list() -> AsyncThrowingStream<[RocketLaunch], Error>
}
