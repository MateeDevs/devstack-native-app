//
//  Created by Petr Chmelar on 22.11.2021
//  Copyright © 2021 Matee. All rights reserved.
//

import DomainLayer

public extension PushNotification {
    static let stub = PushNotification(
        title: "User updated",
        body: "Click for more details",
        type: .userDetail,
        entityId: "5c1a3d7b4a74580016faadf8"
    )
}
