//
//  Created by Petr Chmelar on 05/04/2020.
//  Copyright © 2020 Matee. All rights reserved.
//

public enum PushNotificationType: Int {
    case info = 1
    case userDetail = 2
}

public struct PushNotification: Equatable {
    public let title: String
    public let body: String
    public let type: PushNotificationType
    public let entityId: String
    
    public init(
        title: String,
        body: String,
        type: PushNotificationType,
        entityId: String
    ) {
        self.title = title
        self.body = body
        self.type = type
        self.entityId = entityId
    }
}
